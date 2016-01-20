#!/bin/bash
set -x
unicorn -D -E production -c config/unicorn.rb
