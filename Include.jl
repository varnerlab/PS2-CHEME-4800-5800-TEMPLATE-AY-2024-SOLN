# set the paths -
const _ROOT = @__DIR__
const _PATH_TO_SRC = joinpath(_ROOT, "src");
const _PATH_TO_MY_IMAGES = joinpath(_ROOT, "myimages");
const _PATH_TO_TEST_IMAGES = joinpath(_ROOT, "testimages");

# Do we have the required packages installed? If not install them
using Pkg
Pkg.activate("."); Pkg.resolve(); Pkg.instantiate(); Pkg.update();

# load external packages -
using Images
using ImageInTerminal
using Colors
using FileIO
using Statistics
using Test
using ProgressBars
using Printf
using JLD2

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Compute.jl"));