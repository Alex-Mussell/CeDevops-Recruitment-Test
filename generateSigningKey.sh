#!/bin/bash
if hash figlet 2>/dev/null; then
  echo WARNING: figlet is installed quitting.
  exit 1
else
  echo figlet is not installed
fi
date +"SigningKeyGenerated at %Y-%m-%d-%H-%M" > /tmp/signingKey
