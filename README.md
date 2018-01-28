# condalab

Handy MATLAB utility to switch between conda environments **from within MATLAB**

## Installation

Grab this repo. Chuck it somewhere on your path

## Usage

To view all your conda environments (i.e., the equivalent of `conda env list`)

```matlab
conda.genenv

% You'll see something like this:
asimov     /Users/sg-s/anaconda3/envs/asimov
mctsne     /Users/sg-s/anaconda3/envs/mctsne
*tensorflow     /Users/sg-s/anaconda3/envs/tensorflow
root     /Users/sg-s/anaconda3

```

and the `*` indicates the currently active environment

To switch between environments (i.e., `source activate env`)

```matlab
conda.setenv('env_name')

```

It's that simple. Enjoy. 

## License

GPL v3