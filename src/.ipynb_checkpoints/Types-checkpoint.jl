abstract type AbstractGridWorldRuleModel end

# rule model
mutable struct MyOneDimensionalTwoColorElementaryRuleModel <: AbstractGridWorldRuleModel
    
    # data
    index::Int
    radius::Int
    rule::Dict{Int,Int}

    # constructor -
    MyOneDimensionalTwoColorElementaryRuleModel() = new();
end

mutable struct MyOneDimensionalThreeColorElementaryRuleModel <: AbstractGridWorldRuleModel
    
    # data
    index::Int
    radius::Int
    rule::Dict{Int,Int}

    # constructor -
    MyOneDimensionalThreeColorElementaryRuleModel() = new();
end



