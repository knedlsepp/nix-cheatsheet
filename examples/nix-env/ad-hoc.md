### Listing installed packages
```bash
nix-env -q
```

### Listing available packages
```bash
nix-env -qaP
```

### Installing packages
```bash
nix-env -iA nixpkgs.gitFull
```

### Removing packages
```bash
nix-env -e git
```
(It's best you copy paste the name, which you got from `nix-env -q`)

### Updating packages


First update your channel
```bash
nix-channel --update
```

See what's available
```bash
nix-env -qc
```

Update everything
```bash
nix-env -u --keep-going --leq
```

### Show dependencies
```bash
nix-store --query --references\
  $(nix-instantiate '<nixpkgs>' -A emacs)
```
