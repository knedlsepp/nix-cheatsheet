## Build errors:
### Source/patch not available anymore
If you can find the file somewhere else online, use
```bash
nix-prefetch-url $THE_FILE_THAT_IS_MISSING
```


### Binary cache is down:
If you get a message similar to this:
```bash
download-from-binary-cache.pl: still waiting for ‘https://cache.nixos.org/s62b4isbam2v42yp5vpf1rcxrfpamih6.narinfo’ after 5 seconds...
```
It means cache.nixos.org is currently down. 
You can use the option `--option connect-timeout 2`, to make nix give up on downloading the file after two seconds and starts a local build.