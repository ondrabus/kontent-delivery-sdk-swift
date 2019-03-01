#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
rvm use default
git reset --hard
pod trunk push
