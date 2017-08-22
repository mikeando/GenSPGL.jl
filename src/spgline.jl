export spgline

"""
Non-monotone linesearch
"""
function spgline{TA<:Function, Tf<:Number, ETx<:Number, ETb<:Number}(
                                        A::TA, 
                                        f::Tf,
                                        d::AbstractVector{ETx},
                                        gtd_in::ETx,
                                        x::AbstractArray{ETx}, 
                                        fMax::Tf, 
                                        funForward::Function,
                                        funPenalty::Function,
                                        params::Dict{String,Any},
                                        b::AbstractVector{ETb}, 
                                        feasSrchIt::Int64,
                                        linear::Bool,
                                        options::spgOptions,
                                        timeProject::Float64)

    (options.verbosity > 1) && println("Script entered spgline for A::Function")

    localProdA = 0
    EXIT_CONVERGED = 0
    EXIT_LINEITERATIONS = 1
    maxIts = feasSrchIt
    step::real(ETx) = one(real(ETx))
    iter = zero(Int64)
    gamma = 1e-4
    gtd = -abs(gtd_in)

    if linear
        Ad = funForward(A, d, [], params)[1]::Array(ETb,1)
        localProdA += 1
        r = copy(x)
    end
    
    # Define outputs outside of while loop scope
    rNew::Array{ETb,1} = Array{ETb,1}()
    fNew::Tf = zero(Tf)
    err = -1

    while true 
        
        if linear
            rNew = r - step*Ad
        else
            rNew = b - funForward(A, x + step*d, [], params)[1]
            localProdA += 1
        end

        fNew = funPenalty(rNew, params)[1]

        # Check exit conditions
        if fNew < fMax + gamma*step*gtd
            err = EXIT_CONVERGED
            break
        elseif iter >= maxIts
            err = EXIT_LINEITERATIONS
            break
        end

        iter += 1
        (options.verbosity > 1) && println("Line Search Iter: $iter")
        if step <= 0.1
            step /= 2
        else
            tmp = (-gtd*step^2)/(2*(fNew-f-step*gtd))::real(ETx)
            if (tmp < 0.1) | (tmp > 0.9*step) | (isnan(tmp))
                tmp = step/2
            end
            step = copy(tmp)
        end

    end # while
    
    return fNew, step, rNew, iter, err, localProdA

end # spgline
