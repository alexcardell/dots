#!/bin/sh
nix run github:aksiksi/compose2nix -- \
  -runtime docker \
  -inputs homelab-compose.yaml \
  -output homelab-compose.nix
