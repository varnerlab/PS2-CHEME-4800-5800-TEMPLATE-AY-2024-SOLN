"""
    function simulation(rulemodel::MyOneDimensionalTwoColorElementaryRuleModel, initial::Array{Int64,1};  
        steps::Int64 = 240) -> Dict{Int64, Array{Int64,2}}

This `simulation` function runs a simulation of a one-dimensional cellular automaton model using the `MyOneDimensionalTwoColorElementaryRuleModel` type.

### Arguments
- `rulemodel::MyOneDimensionalTwoColorElementaryRuleModel`: The model to simulate.
- `initial::Array{Int64,1}`: The initial state of the system.
- `steps::Int64`: The number of steps to simulate.

### Return
This function returns a dictionary of frames, where each frame is a matrix of integers representing the state of the system at each step.
"""
function simulation(rulemodel::MyOneDimensionalTwoColorElementaryRuleModel, initial::Array{Int64,1}; 
    steps::Int64 = 240)::Dict{Int64, Array{Int64,2}}
    
    # get stuff from model -
    radius = rulemodel.radius; # how many cells am I looking at?
    number_of_colors = rulemodel.number_of_colors; # how many colors (states) can each cell have?
    width = length(initial); # how many cells are there?

    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    frame = Array{Int64,2}(undef, steps, width) |> X -> fill!(X, 0);

    # set the initial state -
    foreach(i -> frame[1,i] = initial[i], 1:width);    
    frames[1] = frame; # set the initial frame -
    
    # main loop -
    for time ∈ 2:steps

        # create the next frame -
        frame = copy(frames[time-1]);
        tmp = Array{Int64,1}(undef, radius);
        for i ∈ 1:width

            index = nothing;
            if (i == 1)
                
                tmp[1] = frame[time-1, width];      # left
                tmp[2] = frame[time-1, i];          # center
                tmp[3] = frame[time-1, i + 1];      # right

                # compute the index (this is binary, so we need to compute from left to right)
                index = parse(Int, join(tmp), base = number_of_colors);
            elseif (i == width)
                    
                tmp[1] = frame[time-1, i - 1];      # left
                tmp[2] = frame[time-1, i];          # center
                tmp[3] = frame[time-1, 1];          # right
    
                # compute the index (this is binary, so we need to compute from left to right)
                index = parse(Int, join(tmp), base = number_of_colors);
            else
                
                tmp[1] = frame[time-1, i - 1];      # left
                tmp[2] = frame[time-1, i];          # center
                tmp[3] = frame[time-1, i + 1];      # right

                # compute the index (this is binary, so we need to compute from left to right)
                index = parse(Int, join(tmp), base = number_of_colors);
            end
             
            # what is the next state value?
            frame[time,i] = rulemodel.rule[index];
        end

        # set the frame -
        frames[time] = frame;
    end
    
    # return
    return frames;
end
