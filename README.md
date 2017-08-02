# GenSPGL.jl

A Julia solver for large scale minimization problems using any provided norm.
GenSPGL supports implicit arrays(JOLI), explicit arrays, and functions as modelling
operators **__A__**.

This code is an adaptation of Michael P. Friedlander, Ewout van den Berg, and
Aleksandr Aravkin's MATLAB program [SPGL1](http://www.cs.ubc.ca/~mpf/spgl1/). 

## Installation

GenSPGL can be installed using the Julia package manager.
If you have a Github account, run the following from the Julia REPL:

    Pkg.clone("git@github.com:slimgroup/GenSPGL.jl.git")

Otherwise run: 

    Pkg.clone("https://github.com/slimgroup/GenSPGL.jl.git")
## Examples

The scripts for the following examples have been included in the package and can be found in :**/mypath/GenSPGL/src/Examples/**. Where /mypath/ is the path to the Julia source directory.

For example: /home/.julia/v0.6/

### Implicit Array Modelling Operators
**/GenSPGL/src/Examples/compare/jl_cs.jl**

The script solves a small compressive sensing problem using Basis Pursuit Denoise. Data is generated by applying a restriction operator, **R**, to the product of a random matrix, **A**, and the sparse vector, **x**, such that:
**RAx = b**

To run the example start a Julia instance, load the GenSPGL module, and run the example by entering the following in the Julia REPL.

    julia> using GenSPGL
    julia> x, r, g, info, SNR = jl_cs(

For additional information of the ouput, see the package documentation.

    help?> spgl1

### Non Linear Function Modelling Operators and Complex Data
**/GenSPGL/src/Examples/compare/jl_complex.jl**

This example loads a subsampled frequency slice from a seismic data set, and recovers it using a non linear function as the modelling operator. 

GenSPGL supports function handles as modelling operators given in place of explicit/implicit arrays. In addition to this, the package supports applying any norm on **x** by allowing users to define their own projection, dual norm, and primal norm functions. This can easily be done by creating an spgOptions type and changing the default options. Any unspecified parameters will be set to their default values, and if no spgOptions type is given to spgl1 the default options will be used. 

In this example user defined projection, dual norm, and primal norm functions are used instead of the defaults.

    opts = spgOptions(project     = TraceNorm_project,
                      primal_norm = TraceNorm_primal,
                      dual_norm   = TraceNorm_dual)



To run the example, if you have not already done so, load GenSPGL

    julia> using GenSPGL

And call the example function

    julia> x, r, g, info = jl_complex(
        
In addition to returning the output, this function will write the results into the example directory as "xLS_jl.mat". 
        
**/GenSPGL/src/Examples/compare/mat_complex.m** solves the same problem using the MATLAB implementation of the code, and is provided as a means of comparison. 
            
                                                                                                
                                                                                                
                                                                                                
                                                                                                
                                                                                                



