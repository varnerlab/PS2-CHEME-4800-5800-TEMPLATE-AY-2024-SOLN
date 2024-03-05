abstract type AbstractGridWorldRuleModel end

"""
    MyOneDimensionalTwoColorElementaryRuleModel

A type to represent a one-dimensional, two-color, elementary cellular automaton rule.
You build an instance of this type by calling `build(MyOneDimensionalTwoColorElementaryRuleModel, index=i)`, where `i` is the rule number.

### Fields
- `index::Int`: the index of the rule, i.e., the rule number
- `radius::Int`: the radius of the rule (how many cells to look at)
- `rule::Dict{Int,Int}`: the rule dictionary. The key is the integer representation of the neighborhood, and the value is the new state of the cell.
"""
mutable struct MyOneDimensionalTwoColorElementaryRuleModel <: AbstractGridWorldRuleModel
    
    # data
    index::Int
    radius::Int
    rule::Dict{Int,Int}

    # constructor -
    MyOneDimensionalTwoColorElementaryRuleModel() = new();
end

"""
    MyOneDimensionalThreeColorElementaryRuleModel

A type to represent a one-dimensional, three-color, elementary cellular automaton rule.
You build an instance of this type by calling `build(MyOneDimensionalThreeColorElementaryRuleModel, index=i)`, where `i` is the rule number.

### Fields
- `index::Int`: the index of the rule, i.e., the rule number
- `radius::Int`: the radius of the rule (how many cells to look at)
- `rule::Dict{Int,Int}`: the rule dictionary. The key is the integer representation of the neighborhood, and the value is the new state of the cell.
"""
mutable struct MyOneDimensionalThreeColorElementaryRuleModel <: AbstractGridWorldRuleModel
    
    # data
    index::Int
    radius::Int
    rule::Dict{Int,Int}

    # constructor -
    MyOneDimensionalThreeColorElementaryRuleModel() = new();
end



