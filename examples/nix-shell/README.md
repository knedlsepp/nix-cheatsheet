### Starting shells with `--packages` (or `-p`)
```bash
nix-shell --packages git
nix-shell --packages pythonPackages.ipython pythonPackages.numpy
```
### List which packages are availabe
```bash
nix-env -qaP
```

### Starting shells with a `shell.nix` file
In a directory, which contains a `shell.nix` file, simply run:
```bash
nix-shell 
```
- Here is a [simple example](simple-example/shell.nix)
- A [C++ Cmake example](simple-cxx-stuff/shell.nix)
- Pin a nixpkgs version [like this](pinning-nixpkgs/shell.nix)
- Define packages not in the official repository [like this](pinning-nixpkgs-custom-pkgs/shell.nix)

You can find other examples of files [here](./):


### Starting a pure shell via `--pure`
To get a shell cleaned from all environment variables use:
```bash
nix-shell --pure
```

### Running a command via `--run`

```bash
nix-shell -p atom --run "atom"
```

```bash
nix-shell --pure -p pythonPackages.jupyter pythonPackages.numpy --run jupyter-notebook
```

```bash
nix-shell -p ponysay --run "ponysay 'This is great.'"
```

### Keep a nix-shell from being garbage collected
To make a nix-shell persistent and avoid it being garbage collected do the following:

```bash
cd <YOURPROJECT>
mkdir gcroots
nix-shell ./shell.nix --pure --indirect --add-root gcroots/dep
```