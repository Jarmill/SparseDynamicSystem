
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
# f = -x;

#support sets
# Tmax = 0.1;
# Tmax = 3;
Tmax = 10;


R0 = 0.4;
C0 = [1; 0];
Box = 3;

X = Box^2 .- [x[1]^2; x[2]^2];
XT = [X; t*(1-t)]
X0 = [R0^2 - sum((x-C0).^2)]

#order of polynomials/moments (2d)
d = 3; 

# objective to minimize
p = -x[2]; 



#model and auxiliary functions
model = Model(optimizer_with_attributes(Mosek.Optimizer))
set_optimizer_attribute(model, MOI.Silent(), true)
v, vc, vb = add_poly!(model, [t; x], 2d)
gamma = @variable(model); 

#Lie derivative
# deg_change = 1; #floor(degree f/ 2), but I don't know how to take the degree of the polynomial array f
deg_change = 0;
# model,info1 = add_psatz!(model, -Lv, [t; x], XT, [], d, QUIET=true, CS=true, TS="block", Groebnerbasis=false)
Lv = differentiate(v, t) + Tmax * sum(f .* differentiate(v, x))
model,info1 = add_psatz!(model, -Lv, [t; x], XT, [], d+deg_change, QUIET=true, CS=true, TS="block", Groebnerbasis=false)

#cost 
model,info2 = add_psatz!(model, v-p, [t; x], XT, [], d, QUIET=true, CS=true, TS="block", Groebnerbasis=false)

#initial condition
v0 = subs(v, t=>0); #subs(p, y=>x^2)
model,info3 = add_psatz!(model, gamma - v0, x, X0, [], d, QUIET=true, CS=true, TS="block", Groebnerbasis=false)
@objective(model, Min, gamma)
optimize!(model)
status = termination_status(model)
if status != MOI.OPTIMAL
    println("termination status: $status")
    status = primal_status(model)
    println("solution status: $status")
end
objv = objective_value(model)

v_rec = value.(vc)'*vb;
print(objv)