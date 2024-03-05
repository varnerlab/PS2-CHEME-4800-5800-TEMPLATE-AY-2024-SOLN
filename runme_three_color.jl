# include -
include("Include.jl")

# initialize -
number_of_steps = 240;
number_of_states = 2^10;
initial = zeros(Int64, number_of_states);
initial[round(number_of_states/2) |> Int] = 1;
rulesarray = [912,1020,1038,1074,1110,1884,1635,2040];

# main loop -
for i ∈ eachindex(rulesarray)

    # rule index -
    ruleindex = rulesarray[i];

    # build a rule model -
    rulemodel = build(MyOneDimensionalThreeColorElementaryRuleModel, index=ruleindex, radius = 3);
    
    # run simulation -
    old_frames = simulation(rulemodel, initial, steps=number_of_steps, background=0);
    new_frames = Dict{Int64, Array{Float64,2}}();
    
    frame = old_frames[number_of_steps];
    new_frame = Array{Float64,2}(undef, number_of_steps, number_of_states);
    for j ∈ 1:number_of_steps
        for k ∈ 1:number_of_states
            if frame[j,k] == 0
                new_frame[j,k] = 1.0;
            elseif frame[j,k] == 1
                new_frame[j,k] = 0.5;
            elseif frame[j,k] == 2
                new_frame[j,k] = 0.0;
            end
        end
    end
    
    # # save the last frame to disk -
    save(File{format"JPEG"}(joinpath(_PATH_TO_MY_IMAGES, "threecolor", "R$(ruleindex)-F$(number_of_steps).jpeg")), 
         Gray.(new_frame));
end