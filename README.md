# Problem Set 2 (PS2): Developing a System to Compute the Wolfram Elementary Cellular Automata
The objective of `PS2` is to develop a program implemented in the [Julia programming language](https://julialang.org/downloads/) to compute `two-color` [Wolfram Elementary Cellular Automata (ECA)](https://en.wikipedia.org/wiki/Elementary_cellular_automaton).

## Background
[Cellular automata (CA)](https://en.wikipedia.org/wiki/Cellular_automaton) are discrete computational models that consist of a grid of cells, each of which can be in one of a finite number of possible states. CAs are used to model many real-world systems, such as the spread of forest fires, the growth of plants, the behavior of traffic, the behavior of gases, and the behavior of the stock market.
* [Stephen Wolfram](https://en.wikipedia.org/wiki/Stephen_Wolfram), a British-American computer scientist, mathematician, and physicist, studied a particular type of CA called the [Elementary Cellular Automata (ECA)](https://en.wikipedia.org/wiki/Elementary_cellular_automaton), which is a one-dimensional CA. The ECA consists of a line of cells in one of two states: `0` or `1`. The state of each cell is determined by the state of its two neighbors in the previous time step, according to a rule table. 

The Worlfram book is accessible on the [Wolfram Science website](https://www.wolframscience.com/nks/).

## Two-Color ECA
In `Part 1` of `PS2`, you will implement a program to compute all 256 two-color ECAs for 240 generations. Cells can be in one of two states: `0` or `1`. The program visualizes the last ECA generation (i.e., the `240th` generation) by writing an image for each rule to disk.

### Tasks Part 1
The public `application programming interface (API)` for part 1 of this problem set consists of the following types and functions:
1. Create the `MyOneDimensionalTwoColorElementaryRuleModel` type to represent a two-color ECA rule in the `src/Types.jl` file. `MyOneDimensionalTwoColorElementaryRuleModel` should be `mutable` and have three fields:       
    * The `index::Int` field holds the index of the rule (an integer between `0` and `255`)
    * The `rule::Dict{Int, Int}` field holds the rule table (mapping between neighborhood and next state)
    * The `radius::Int` field holds the radius of the rule (how many cells are used to determine the state of the next cell; in the case of a two-color ECA, the radius is `3`).

2. Create a `build` method in the `src/Factory.jl` file with the signature:
    ```julia
        function build(modeltype::Type{MyOneDimensionalTwoColorElementaryRuleModel}; 
            index::Int64 = 0, radius::Int64 = 3, 
            levels::Int64 = 2)::MyOneDimensionalTwoColorElementaryRuleModel
    ```
    The `build` method should return a `MyOneDimensionalTwoColorElementaryRuleModel` object with the given `index.` The `rule` field of the `MyOneDimensionalTwoColorElementaryRuleModel` object should be initialized with the rule table for the given `index.` The `radius` field of the `MyOneDimensionalTwoColorElementaryRuleModel` object should be initialized with the radius of the rule. The `levels` argument is the number of states a cell can be in; in the case of a two-color ECA, the number of levels is `2`.

3. Complete the implementation of the `simulation` function in the `src/Compute.jl` file, where `simulation` has the signature:

    ```julia
        function simulation(rulemodel::MyOneDimensionalTwoColorElementaryRuleModel, 
            initial::Array{Int64,1}; steps::Int64 = 240, 
            background::Int64 = 1)::Dict{Int64, Array{Int64,2}}
    ```
    
    The `simulation` function should return a `Dict{Int64, Array{Int64,2}}` which stores each frame of the ECA simulation in a dictionary where the `key` is the frame index (generation number) and the `value` is an `Array{Int64,2}`. Assume periodic boundary conditions, i.e., the first and last cells are neighbors. The `simulation` function should use the `rule` field of the `rulemodel` argument to compute the next state of the ECA at each generation.

The `runme.jl` script builds the rules, runs the simulation, generates ECA images, and saves the image of the last generation of each rule to the `myimages/twocolor` directory. The `testme.jl` script checks the validity of your image library against the expected images stored in the `testimages/twocolor` directory.

For more information (and examples) describing two-color rule numbering and rule table construction, see [Chapter 3 of "A New Kind of Science," Wolfram S, 2002](https://cornell.box.com/s/10md9xuf184a6s3c25n6005uuia7da1e). 