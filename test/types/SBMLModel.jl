
sbmlfile = joinpath("data", "ecoli_core.xml")
download_data_file(
    "http://systemsbiology.ucsd.edu/sites/systemsbiology.ucsd.edu/files/Attachments/Images/downloads/Ecoli_core/ecoli_core_model.xml",
    sbmlfile,
    "78692f8509fb36534f4f9b6ade23b23552044f3ecd8b48d84d484636922ae907",
)

@testset "Conversion from and to SBML model" begin
    sbmlm = read_model(sbmlfile, SBMLModel)
    cm = convert(CoreModel, sbmlm) #TODO use a richer intermediate model
    sbmlm2 = convert(SBMLModel, cm)

    @test Set(reactions(sbmlm)) == Set(reactions(sbmlm2))
    @test Set(metabolites(sbmlm)) == Set(metabolites(sbmlm2))
    @test all([
        sbmlm.m.reactions[i].stoichiometry == sbmlm2.m.reactions[i].stoichiometry for
        i in reactions(sbmlm2)
    ])
end