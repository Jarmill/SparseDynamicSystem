All files are in the `example` folder

# Works Perfectly
### Maximum Positive Invariant set estimation:

mpi_example.jl: with add_psatz!()

mpi_noadd.jl: without add_psatz!()


# No matching method with degree

### Barrier functions
barrier_example.jl
```
ERROR: MethodError: no method matching degree(::Monomial{true}, ::Vector{PolyVar{true}})
Closest candidates are:
  degree(::AbstractMonomial, ::MultivariatePolynomials.AbstractVariable) at C:\Users\jared\Juliawin\userdata\.julia\packages\MultivariatePolynomials\sWAOE\src\monomial.jl:78
  degree(::AbstractTermLike) at C:\Users\jared\Juliawin\userdata\.julia\packages\MultivariatePolynomials\sWAOE\src\monomial.jl:70
  degree(::AbstractTermLike, ::MultivariatePolynomials.AbstractVariable) at C:\Users\jared\Juliawin\userdata\.julia\packages\MultivariatePolynomials\sWAOE\src\monomial.jl:72
Stacktrace:
 [1] poly_info(p::Polynomial{true, AffExpr}, x::Vector{Vector{PolyVar{true}}})
   @ SparseDynamicSystem C:\Users\jared\Juliawin\userdata\.julia\packages\SparseDynamicSystem\IaOAS\src\getblock.jl:128
 [2] add_psatz!(model::Model, nonneg::Polynomial{true, AffExpr}, vars::Vector{Vector{PolyVar{true}}}, ineq_cons::Vector{Any}, eq_cons::Vector{Any}, order::Int64; CS::Bool, TS::String, SO::Int64, Groebnerbasis::Bool, QUIET::Bool)
   @ SparseDynamicSystem C:\Users\jared\Juliawin\userdata\.julia\packages\SparseDynamicSystem\IaOAS\src\add_psatz.jl:42
 [3] top-level scope
   @ c:\Users\jared\.julia\SparseDynamicSystem\example\barrier_example.jl:35
```

# Indexing error (off the end of the array)
### Polynomial Optimization
polyopt_example.jl
```
ERROR: BoundsError: attempt to access 3×30 Matrix{UInt8} at index [1:3, 31]
Stacktrace:
 [1] throw_boundserror(A::Matrix{UInt8}, I::Tuple{Base.Slice{Base.OneTo{Int64}}, Int64})
   @ Base .\abstractarray.jl:703
 [2] checkbounds
   @ .\abstractarray.jl:668 [inlined]
 [3] _setindex!
   @ .\multidimensional.jl:929 [inlined]
 [4] setindex!
   @ .\abstractarray.jl:1344 [inlined]
 [5] add_psatz!(model::Model, nonneg::Polynomial{true, AffExpr}, vars::Vector{PolyVar{true}}, ineq_cons::Vector{Polynomial{true, Int64}}, eq_cons::Vector{Any}, order::Int64; CS::Bool, TS::String, SO::Int64, Groebnerbasis::Bool, QUIET::Bool)
   @ SparseDynamicSystem C:\Users\jared\Juliawin\userdata\.julia\packages\SparseDynamicSystem\IaOAS\src\add_psatz.jl:76
 [6] top-level scope
   @ c:\Users\jared\.julia\SparseDynamicSystem\example\polyopt_example.jl:23
   ```
   
### Peak Estimation
peak_example.jl
```

-----------------------------------------------------------------------------
The clique sizes of varibles:
[2, 1]
[1, 1]
-----------------------------------------------------------------------------
ERROR: BoundsError: attempt to access 3×18 Matrix{UInt8} at index [1:3, 19]
Stacktrace:
 [1] throw_boundserror(A::Matrix{UInt8}, I::Tuple{Base.Slice{Base.OneTo{Int64}}, Int64})
   @ Base .\abstractarray.jl:703
 [2] checkbounds
   @ .\abstractarray.jl:668 [inlined]
 [3] _setindex!
   @ .\multidimensional.jl:929 [inlined]
 [4] setindex!
   @ .\abstractarray.jl:1344 [inlined]
 [5] add_psatz!(model::Model, nonneg::Polynomial{true, AffExpr}, vars::Vector{PolyVar{true}}, ineq_cons::Vector{Polynomial{true, Int64}}, eq_cons::Vector{Any}, order::Int64; CS::Bool, TS::String, SO::Int64, Groebnerbasis::Bool, QUIET::Bool)
   @ SparseDynamicSystem C:\Users\jared\Juliawin\userdata\.julia\packages\SparseDynamicSystem\IaOAS\src\add_psatz.jl:76
 [6] top-level scope
   @ c:\Users\jared\.julia\SparseDynamicSystem\example\peak_example.jl:40
   ```
