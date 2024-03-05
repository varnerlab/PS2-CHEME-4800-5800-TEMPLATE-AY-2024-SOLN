include("Include.jl")

# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------
# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "PS2 Test Suite Part 2" begin

    @testset "Build MyOneDimensionalThreeColorElementaryRuleModel test" begin
        
        # initialize
        ruleindex = 1635;
        testrule = Dict{Int,Int}();
        testrule[0] = 0;
        testrule[1] = 2;
        testrule[2] = 1;
        testrule[3] = 0;
        testrule[4] = 2;
        testrule[5] = 0;
        testrule[6] = 2;
    
        # build a rule model -
        rulemodel = build(MyOneDimensionalThreeColorElementaryRuleModel, index=ruleindex, radius = 3);
    
        # correct type?
        @test typeof(rulemodel) == MyOneDimensionalThreeColorElementaryRuleModel;
    
        # correct index?
        @test rulemodel.index == ruleindex;
    
        # correct rule dictionary?
        @test rulemodel.rule == testrule;
    end

    @testset "Three color image identity tests" begin

        # initialize -
        number_of_steps = 240;
        number_of_states = 2^10;
        initial = zeros(Int64, number_of_states);
        initial[round(number_of_states/2) |> Int] = 1;
        rules = [912,1020,1038,1074,1110,1884,1635,2040];

        # main test loop -
        for i ∈ eachindex(rules)

            # rule index -
            ruleindex = rules[i];

            # load image from my image list -
            my_image = load(joinpath(_PATH_TO_MY_IMAGES,"threecolor", "R$(ruleindex)-F$(number_of_steps).jpeg"));
            my_test_image = load(joinpath(_PATH_TO_TEST_IMAGES, "threecolor", "TEST_R$(ruleindex)-F$(number_of_steps).jpeg"));
            
            # test -
            @test my_image == my_test_image;
        end
    end
end
