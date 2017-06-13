# SPGL

export spgl1

"""
This will contain info on use of spgl1
"""
function spgl1{xT<:AbstractFloat}(A::AbstractArray, b::AbstractArray;
                    x::AbstractArray{xT}=Float64[],
                    tau::AbstractFloat=NaN,
                    sigma::AbstractFloat=NaN,
                    options::spgOptions = spgOptions(),
                    params::Dict{String,Number} = Dict{String,Number}())

    #DEVNOTE# Could make Tau and Sigma nullable types? However, as long as
    # Tau and Sigma are always Float64 this wont be a problem
    println("Script made it to spgl1")

    #Add options proxy to params dict
    params["proxy"] = options.proxy

    # Check Tau and Sigma
    if isnan(tau) & isnan(sigma)
        tau = 0.
        sigma = 0.
        singleTau = false
    elseif isnan(sigma)
        singleTau = true
    else
        if isnan(tau)
            tau = 0.
        end
        singleTau = false
    end

    # Definitely dont do subspacemin in the non LS case
    #DEVNOTE# Make sure name matches once funLS is written
    string(options.funPenalty)=="GenSPGL.funLS" || (options.subspaceMin = 0) 
    
    # Threshold for signifigant Newton step
    pivTol = 1e-12

    ##--------------------------------------------------------------------------------
    # Initialize Local Variables
    ##--------------------------------------------------------------------------------  
    iter = 0; itnTotLSQR = 0 #Total SPGL1 and LSQR iterations.
    nProdA = 0; nProdAt = 0
    lastFv = [-Inf for i=1:options.nPrevVals] # Last m functions values
    nLineTot = 0 # Total number of linesearch steps
    pintTau = false
    nNewton = 0;
    
    #DEVNOTE# Consider making a composite params type for each funPenalty instead of
            # the current Dict solution
    bNorm, b_normalized = options.funPenalty(b, params)

    stat = false
    timeProject = 0
    timeMatProd = 0
    nnzIter = 0 # No. of Its with fixed pattern
    nnzIdx = [] # Active set indicator
    subspace = false # Flag if did subspace min in current itn
    stepG = 1 # Step length for projected gradient
    testUpdateTau = 0

    ##-------------------------------------------------------------------------------
    # End Init
    ##-------------------------------------------------------------------------------

    # Determine Initial x, vector length n, and check if complex

    

   


end #func

