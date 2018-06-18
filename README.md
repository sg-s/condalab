# condalab

Handy MATLAB utility to switch between conda environments **from within MATLAB**

## Installation

1. Grab this repo. Chuck it somewhere on your path.
2. Determine where your base `conda` installation by opening a terminal and typing `which conda`. Make a note of that path
3. Add this to your `MATLAB` startup file: 

```MATLAB
path1 = getenv('PATH');
if isempty(strfind(path1,':/path/to/conda'))
    path1 = [path1 ':path/to/conda'];
end
setenv('PATH', path1);
```


## Usage

To view all your conda environments (i.e., the equivalent of `conda env list`)

```matlab
conda.getenv()

% You'll see something like this:
asimov          /Users/sg-s/anaconda3/envs/asimov
mctsne          /Users/sg-s/anaconda3/envs/mctsne
*tensorflow     /Users/sg-s/anaconda3/envs/tensorflow
root            /Users/sg-s/anaconda3

```

and the `*` indicates the currently active environment

To switch between environments (i.e., `source activate env`)

```matlab
conda.setenv('env_name')

```

It's that simple. Enjoy. 
