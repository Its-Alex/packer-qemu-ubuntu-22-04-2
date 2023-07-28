#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

vagrant box add --force packer-build-baremetal-ubuntu-22.04.2-amd64 ./output-vagrant/package.box
