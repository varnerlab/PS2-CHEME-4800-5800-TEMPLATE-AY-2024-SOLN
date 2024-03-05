# load external packages, and my codes -
include("Include.jl")


# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------
# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "PS2 Test Suite Part 1" begin

    @testset "Build MyOneDimensionalTwoColorElementaryRuleModel test" begin
        
        # initialize
        ruleindex = 30;
        testrule = Dict{Int,Int}();
        testrule[0] = 0;
        testrule[1] = 1;
        testrule[2] = 1;
        testrule[3] = 1;
        testrule[4] = 1;
        testrule[5] = 0;
        testrule[6] = 0;
        testrule[7] = 0;

        # build a rule model -
        rulemodel = build(MyOneDimensionalTwoColorElementaryRuleModel, index=ruleindex, radius = 3);

        # correct type?
        @test typeof(rulemodel) == MyOneDimensionalTwoColorElementaryRuleModel;

        # correct index?
        @test rulemodel.index == ruleindex;

        # correct rule dictionary?
        @test rulemodel.rule == testrule;
    end

    @testset "Two color image identity tests" begin

        # initialize -
        number_of_steps = 240;
        number_of_states = 2^10;
        initial = zeros(Int64, number_of_states);
        initial[round(number_of_states/2) |> Int] = 1;
        rules = range(0, stop=255, step=1) |> collect; # all elementary rules 0 ... 255

        # main test loop -
        for i ∈ eachindex(rules)

            # load image from my image list -
            my_image = load(joinpath(_PATH_TO_MY_IMAGES,"twocolor", "R$(i)-F240.jpeg"));
            my_test_image = load(joinpath(_PATH_TO_TEST_IMAGES, "twocolor", "TEST_R$(i)-F240.jpeg"));
            
            # test -
            @test my_image == my_test_image;
        end
    end
end