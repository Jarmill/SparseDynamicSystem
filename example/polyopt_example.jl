
#Author: Jared Miller
# based on the MPI demo of Jie Wang, https://github.com/wangjie212/SparseDynamicSystem/blob/main/example/example.jl
using JuMP
using Revise
using MosekTools
using DynamicPolynomials
using MultivariatePolynomials
using SparseDynamicSystem

n = 3;
@polyvar x[1:n]
# f = x'*x + 3*x[1]^4*x[2]*x[3];
f = x'*x + 1 + x[1]*x[2]; 
# f = x'*x + 1;
# g = [1-x[1]^2, 1-x[2]^2, 1-x[3]^2]
g = [];
# h = 1-sum(x.^2);
h = [1-sum(x.^2)];
# h = [];
d = 5;

model = Model(optimizer_with_attributes(Mosek.Optimizer));
set_optimizer_attribute(model, MOI.Silent(), true);
gamma = @variable(model);

model,info1 = add_psatz!(model, f-gamma, x, g, h, d, QUIET=true, CS=true, TS="block", constrs="con1")

@objective(model, Max, gamma)
optimize!(model)
status = termination_status(model)
if status != MOI.OPTIMAL
    println("termination status: $status")
    status = primal_status(model)
    println("solution status: $status")
end
objv = objective_value(model)

moment = [-dual(constraint_by_name(model, "con1[$i]")) for i=1:size(info1.tsupp, 2)]
MomMat = get_moment_matrix(moment, info1.tsupp, info1.cql, info1.basis)