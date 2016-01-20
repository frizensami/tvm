#!/bin/bash
set -x
unicorn -E production -c config/unicorn.rb
