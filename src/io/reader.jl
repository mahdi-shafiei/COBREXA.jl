"""
Load a model in MAT (Matlab) format and returns a `LinearModel`

See also: `MAT.jl`
"""
function loadModel(filePath::String, varName::String)

    # open file and read
    file = matopen(filePath)
    vars = matread(filePath)


    if exists(file, varName)

        return convertToLinearModel(vars[varName])

    else
        error("Variable `varName` does not exist in the specified MAT file.")
    end
    close(file)
end

"""
Convert a dictionary read from a MAT file to LinearModel
"""
function convertToLinearModel(model::Dict)
    modelKeys = ["S", "b", "c", "ub", "lb"]

    for key = modelKeys
        if !(key in keys(model))
            error("No variable $key found in the MAT file.")
        end
    end

    S = model["S"]
    b = vec(model["b"])
    c = vec(model["c"])
    ub = vec(model["ub"])
    lb = vec(model["lb"])
    rxns = vec(string.(model["rxns"]))
    mets = vec(string.(model["mets"]))

    return LinearModel(S, b, c, lb, ub, rxns, mets)
end