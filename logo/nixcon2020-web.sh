#!/usr/bin/env nix-shell
#!nix-shell -p nodePackages.svgo -i bash

svgo -i nixcon2020-logo.svg -o nixcon2020-web.svg

