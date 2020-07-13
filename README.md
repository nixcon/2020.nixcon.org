<a href="https://travis-ci.org/nixcon/2020.nixcon.org"><img src="https://travis-ci.org/nixcon/2020.nixcon.org.svg?branch=master"></a>

# Website for NixCon 2020

Copied from https://github.com/cko/nixcon2017

## Build

The site is built with [Hakyll](https://jaspervdj.be/hakyll/)

    ghc --make site.hs
    site build
    site server

Watch and recompile for changes with `site watch`

### Build with nix

    nix-build

## Travis Deployment

```sh
ssh-keygen -f deploy-key
travis encrypt-file --org -r nixcon/2020.nixcon.org deploy-key
rm deploy-key
git add travis-deployment
# ...git commit & push
```

Then go to https://github.com/nixcon/2020.nixcon.org/settings/keys and add the
`deploy-key.pub` to the deploy keys, with write access.
