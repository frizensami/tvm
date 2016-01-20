#!/bin/bash
kill $(ps aux | grep '[u]nicorn master' | awk '{print $2}')

