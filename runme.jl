# include -
include("Include.jl")

# initialize -
number_of_colors = 2;
radius = 3;
number_of_steps = 240;
number_of_states = 2^10;
initial = zeros(Int64, number_of_states);
initial[round(number_of_states/2) |> Int] = 1;
rules = range(0, stop=255, step=1) |> collect; # all elementary rules 0 ... 255
image_dictionary = Dict{Int64, Matrix{Gray{N0f8}}}();

# main loop -
for i ∈ eachindex(rules)

    # build a rule model -
    rulemodel = build(MyOneDimensionalTwoColorElementaryRuleModel, 
        (index = i, colors = number_of_colors, radius = radius));
    
    # run simulation -
    frames = simulation(rulemodel, initial, steps=number_of_steps);
    
    # make an image, and store it in the dictionary -
    tmp_image = Gray.(1 .- frames[number_of_steps]);

    # # save the last frame to disk -
    save(File{format"JPEG"}(joinpath(_PATH_TO_MY_IMAGES, "twocolor", "R$(i)-F$(number_of_steps).jpeg")), 
         Gray.(1 .- frames[number_of_steps]));

    # store the image in the dictionary -
    # image_dictionary[i] = tmp_image;
end

# dump to disk -
# save(joinpath(_PATH_TO_TEST_DATA, "twocolor_test_image_dataset.jld2"), Dict("dataset" => image_dictionary));