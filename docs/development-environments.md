### Starting shells with `--packages`
```
nix-shell --packages git catclock
```

### Starting shells with a `shell.nix` file
```
# In a directory, which contains a `shell.nix` file, simply run:
nix-shell 
```

### Starting a pure shell
To get a shell cleaned from all environment variables use:
```
nix-shell --pure
```
