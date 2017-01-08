# nix-cheatsheet
I use this repository as a reference for the `nix` commands, which I use most frequently.

# Development environments

## Starting shells via command line options
```
nix-shell -p git catclock
```

## Starting shells with a `shell.nix` file
```
# In a directory, which contains a `shell.nix` file, simply run:
nix-shell 
```

## Starting a pure shell
To get a shell cleaned from all environment variables use:
```
nix-shell --pure
```
