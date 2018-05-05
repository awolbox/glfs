#!/bin/bash

readonly script='.makesrc.sh'

# Environment 
cat makesrc | head -n $(cat makesrc | grep -n "FILE DELIMETER" | cut -d ":" -f 1) > $script

#
