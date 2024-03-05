"""
    build(modeltype::Type{MyOneDimensionalTwoColorElementaryRuleModel}; 
        index::Int64 = 0, radius::Int64 = 3, levels::Int64 = 2) -> MyOneDimensionalTwoColorElementaryRuleModel

Build a `MyOneDimensionalTwoColorElementaryRuleModel` instance using the specified parameters.
The `index` parameter is the rule number, and the `radius` parameter is the radius of the rule.

### Arguments
- `modeltype::Type{MyOneDimensionalTwoColorElementaryRuleModel}`: the type of the model to build
- `index::Int64 = 0`: the rule number, i.e., an Int between 0 and 255
- `radius::Int64 = 3`: the radius of the rule (how many cells to look at)
- `levels::Int64 = 2`: the number of levels (colors) in the rule: in this case, 2 (black or white)

### Returns
- `MyOneDimensionalTwoColorElementaryRuleModel`: an instance of the model with the fields populated
"""
function build(modeltype::Type{MyOneDimensionalTwoColorElementaryRuleModel}; 
    index::Int64 = 0, radius::Int64 = 3, levels::Int64 = 2)::MyOneDimensionalTwoColorElementaryRuleModel

    # create instance
    model = MyOneDimensionalTwoColorElementaryRuleModel();
    rule = Dict{Int,Int}();

    # build the rule -
    number_of_states = levels^radius;
    states = digits(index, base=levels, pad=number_of_states);
    for i ∈ 0:number_of_states-1
        rule[i] = states[i+1];
    end
    
    # set the data on the object
    model.index = index;
    model.rule = rule;
    model.radius = radius;

    # return
    return model;
end

"""
    build(modeltype::Type{MyOneDimensionalThreeColorElementaryRuleModel}; 
        index::Int64 = 0, radius::Int64 = 3, levels::Int64 = 3) ->  MyOneDimensionalThreeColorElementaryRuleModel

Build a `MyOneDimensionalThreeColorElementaryRuleModel` instance using the specified parameters.

### Arguments
- `modeltype::Type{MyOneDimensionalThreeColorElementaryRuleModel}`: the type of the model to build
- `index::Int64 = 0`: the rule number, i.e., an Int between 0 and 6560
- `radius::Int64 = 3`: the radius of the rule (how many cells to look at)
- `levels::Int64 = 3`: the number of levels (colors) in the rule: in this case, 3 (black, white, or gray)

### Returns
- `MyOneDimensionalThreeColorElementaryRuleModel`: an instance of the model with the fields populated
"""
function build(modeltype::Type{MyOneDimensionalThreeColorElementaryRuleModel}; 
    index::Int64 = 0, radius::Int64 = 3, levels::Int64 = 3) :: MyOneDimensionalThreeColorElementaryRuleModel

    # create instance
    model = modeltype();
    rule = Dict{Int,Int}();

    # build the rule -
    number_of_states = 7; # why 7? 3^3 = 27, but we only have 7 states??
    states = digits(index, base = levels, pad = number_of_states);
    for i ∈ 0:number_of_states-1
        rule[i] = states[i+1];
    end
    
    # set the data on the object
    model.index = index;
    model.rule = rule;
    model.radius = radius;

    # return
    return model;
end 