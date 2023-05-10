#Barrier function example
#Author: Jie Wang, https://github.com/wangjie212/SparseDynamicSystem/blob/main/example/example.jl
using JuMP
using Revise
using MosekTools
using DynamicPolynomials
using MultivariatePolynomials
using SparseDynamicSystem
#variables
n = 2
@polyvar t
@polyvar x[1:n]

#system
f = [x[2]; -x[1] - x[2] + x[1]^3/3]

#support sets
Tmax = 5;
# X = [4-x[1]^2, 4-x[2]^2];
X = [];
X0 = [0.4^2 - x[2]^2 - (x[1] - 1.5)^2]
Xu = [0.5^2 - x[1]^2 - (x[2]+0.7)^2; 0.7 - x[1]-x[2]]
d = 3


#model and auxiliary functions
model = Model(optimizer_with_attributes(Mosek.Optimizer))
set_optimizer_attribute(model, MOI.Silent(), true)
v, vc, vb = add_poly!(model, x, 2d)

#Lie derivative
deg_change = 1; #floor(degree f/ 2), but I don't know how to take the degree of the polynomial array f
# deg_change = 0;
Lv =  sum(f .* differentiate(v, x));
model,info1 = add_psatz!(model, Lv, [ x], [], [], d+deg_change, QUIET=true, CS=true, TS="block", SO=1, Groebnerbasis=false)

#unsafe set
model,info3 = add_psatz!(model, -v, [x], Xu, [], d, QUIET=true, CS=true, TS="block", SO=1, Groebnerbasis=false)

#initial condition
epsilon = 1e-3;
model,info3 = add_psatz!(model, v + epsilon, [x], X0, [], d, QUIET=true, CS=true, TS="block", SO=1, Groebnerbasis=false)

@objective(model, Min, 0)
optimize!(model)
status = termination_status(model)
if status != MOI.OPTIMAL
    println("termination status: $status")
    status = primal_status(model)
    println("solution status: $status")
end
objv = objective_value(model)
