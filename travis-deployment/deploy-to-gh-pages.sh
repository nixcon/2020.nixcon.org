#!/usr/bin/env bash
set -euo pipefail

echo decrypting the ssh key ...

openssl aes-256-cbc \
  -K "$encrypted_92725ca94bf5_key" -iv "$encrypted_92725ca94bf5_iv" \
  -in deploy-key.enc -out ~/.ssh/id_rsa -d
chmod 0700 ~/.ssh
chmod 0600 ~/.ssh/id_rsa

echo "start deployment ..."

GH_REF=git@github.com:nixcon/2020.nixcon.org.git

TMP_CHECKOUT_DIR=tmp/origin-gh-pages
(
  set -e
  git clone --branch=gh-pages "$GH_REF" $TMP_CHECKOUT_DIR

  echo "deploy: checked out 'gh-pages' branch"
  rm -rf ${TMP_CHECKOUT_DIR:?}/*
  cp -r result/* $TMP_CHECKOUT_DIR
  cp CNAME $TMP_CHECKOUT_DIR
  cd $TMP_CHECKOUT_DIR

  echo "deploy: adding files"
  git config --global user.name "Travis CI"
  git config --global user.email "mail@example.com"
  # `--all` ensures that only the files from the last build end in the repo
  git add --all .

  echo "deploy: committing"
  git commit -m "Travis deployed 'master' - $(date)" || true

  echo "deploy: push to gh-pages"
  git push origin gh-pages:gh-pages
)
