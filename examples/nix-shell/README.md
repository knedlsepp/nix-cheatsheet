### Starting shells with `--packages`
```bash
nix-shell --packages git catclock
```

### List which packages are availabe
```bash
nix-env -qaP
```

### Starting shells with a `shell.nix` file
```bash
# In a directory, which contains a `shell.nix` file, simply run:
nix-shell 
```

### Starting a pure shell via `--pure`
To get a shell cleaned from all environment variables use:
```bash
nix-shell --pure
```

### Running a command via `--run`

```bash
nix-shell -p atom --run "atom"
```

Write something important to the terminal
```bash
nix-shell --pure -p ponysay --run "ponysay 'This is great.'"
```

