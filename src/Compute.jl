"""
    simulation(rulemodel::MyOneDimensionalTwoColorElementaryRuleModel, initial::Array{Int64,1};  
        steps::Int64 = 240, background::Int64 = 1)::Dict{Int64, Array{Int64,2}}

Run a simulation of a one-dimensional, two-color, elementary cellular automaton where we assume periodic boundary conditions.

### Arguments
- `rulemodel::MyOneDimensionalTwoColorElementaryRuleModel`: the rule model to use
- `initial::Array{Int64,1}`: the initial state of the system
- `steps::Int64 = 240`: the number of steps to run the simulation
- `background::Int64 = 1`: the default background color

### Returns
- `Dict{Int64, Array{Int64,2}}`: a dictionary of the frames of the simulation, where the `key` is the time step and the `value` is the frame
"""
function simulation(rulemodel::MyOneDimensionalTwoColorElementaryRuleModel, initial::Array{Int64,1};  
    steps::Int64 = 240, background::Int64 = 1)::Dict{Int64, Array{Int64,2}}
    
    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    width = length(initial);
    radius = rulemodel.radius;

    # set the initial state -
    frame = Array{Int64,2}(undef, steps, width);    
    #fill!(frame, background);
    for i ∈ 1:width
        frame[1,i] = initial[i];
    end
    frames[1] = frame; # set the initial frame -
    
    # main loop -
    iter = ProgressBar(2:steps);
    for time in 2:steps

        # create the next frame -
        frame = copy(frames[time-1]);
        tmp = Array{Int64,1}(undef, radius);
        for i ∈ 1:width

            index = nothing;
            if (i == 1)
                
                tmp[1] = frame[time-1, width];  # left
                tmp[2] = frame[time-1, i];      # center
                tmp[3] = frame[time-1, i + 1];    # right

                # compute the index (this is binary, so we need to compute from left to right)
                index = parse(Int, join(tmp), base = 2);

            elseif (i == width)
                    
                tmp[1] = frame[time-1, i - 1];  # left
                tmp[2] = frame[time-1, i];      # center
                tmp[3] = frame[time-1, 1];      # right
    
                # compute the index (this is binary, so we need to compute from left to right)
                index = parse(Int, join(tmp), base = 2);

            else
                
                tmp[1] = frame[time-1, i - 1];  # left
                tmp[2] = frame[time-1, i];      # center
                tmp[3] = frame[time-1, i + 1];  # right

                # compute the index (this is binary, so we need to compute from left to right)
                index = parse(Int, join(tmp), base = 2);

            end
             
            # what is the next state value?
            frame[time,i] = rulemodel.rule[index];
        end

        # set the frame -
        frames[time] = frame;

        # set the progress bar -
        set_postfix(iter, Rule=@sprintf("%.2f", rulemodel.index))
    end
    
    # return
    return frames;
end

"""
    simulation(rulemodel::MyOneDimensionalThreeColorElementaryRuleModel, initial::Array{Int64,1};  
        steps::Int64 = 240, background::Int64 = 1)::Dict{Int64, Array{Int64,2}}

Run a simulation of a one-dimensional, three-color, elementary cellular automaton where we assume periodic boundary conditions.

### Arguments
- `rulemodel::MyOneDimensionalThreeColorElementaryRuleModel`: the rule model to use
- `initial::Array{Int64,1}`: the initial state of the system
- `steps::Int64 = 240`: the number of steps to run the simulation
- `background::Int64 = 1`: the default background color

### Returns
- `Dict{Int64, Array{Int64,2}}`: a dictionary of the frames of the simulation, where the `key` is the time step and the `value` is the frame
"""
function simulation(rulemodel::MyOneDimensionalThreeColorElementaryRuleModel,  initial::Array{Int64,1};  
    steps::Int64 = 10, background::Int64 = 1)::Dict{Int64, Array{Int64,2}}
    
    # initialize -
    frames = Dict{Int64, Array{Int64,2}}();
    width = length(initial);
    radius = rulemodel.radius;

    # policy -> we need to create a dictionary that maps the mean value to the state index -
    # Q: mean value -> state index
    # I love this impl, but I don't  *love,love* this impl if you know what I'm saying, but it's a start -
    Q = Dict{Float64, Int64}();
    Q[0.0] = 0;     # state 1
    Q[0.33] = 1;    # state 2
    Q[0.67] = 2;    # state 3
    Q[1.0] = 3;     # state 4
    Q[1.33] = 4;    # state 5
    Q[1.67] = 5;    # state 6
    Q[2.0] = 6;     # state 7

    # set the initial state -
    frame = Array{Int64,2}(undef, steps, width);    
    fill!(frame, background);
    for i ∈ 1:width
        frame[1,i] = initial[i];
    end
    frames[1] = frame; # set the initial frame -
    
    # main loop -
    iter = ProgressBar(2:steps);
    for time in iter

        # create the next frame -
        frame = copy(frames[time-1]);
        tmp = Array{Int64,1}(undef, radius);
        for i ∈ 1:width

            index = nothing;
            if (i == 1)
                
                tmp[1] = frame[time-1, width];  # left
                tmp[2] = frame[time-1, i];      # center
                tmp[3] = frame[time-1, i + 1];    # right

                # ok, compute the mean value -
                mean_value_key = mean(tmp);
                index = Q[round(mean_value_key,digits=2)];

            elseif (i == width)
                
                tmp[1] = frame[time-1, i - 1];  # left
                tmp[2] = frame[time-1, i];      # center
                tmp[3] = frame[time-1, 1];      # right

                # ok, compute the mean value -
                mean_value_key = mean(tmp);
                index = Q[round(mean_value_key,digits=2)];
            
            else
                
                tmp[1] = frame[time-1, i - 1];   # left
                tmp[2] = frame[time-1, i];      # center
                tmp[3] = frame[time-1, i + 1];  # right

                # ok, compute the mean value -
                mean_value_key = mean(tmp);
                index = Q[round(mean_value_key,digits=2)];
            end
             
            # what is the next state value?
            frame[time,i] = rulemodel.rule[index];
        end

        # set the frame -
        frames[time] = frame;

        # set the progress bar -
        set_postfix(iter, Rule=@sprintf("%.2f", rulemodel.index))
    end
    
    # return
    return frames;
end