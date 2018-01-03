#! /usr/bin/env nix-shell
#! nix-shell --pure -i python -p 'python3.withPackages(ps: with ps; [ prettytable requests ])'

import prettytable

# Print a simple table.
t = prettytable.PrettyTable(["N", "N^2"])
for n in range(1, 10): t.add_row([n, n * n])
print(t)

#######

import requests
r = requests.get('https://api.github.com/events')
r = requests.post('http://httpbin.org/post', data = {'key':'value'})
print(r)

