#!/bin/bash
_executive_=makesrc.sh

readonly torn_executive="$(printf '%s\n' "_$executive_" | cut -d "." -f 1)"

_functions()
{
		typeset -a all
		all=($@)
		
		while read -r line
		do
				for $line in "$all"
				do
						:# Find function name in line
						 # Grab it
						 # Cat it into $torn_executive
				done
		done < "vars"
}

# Check current working directory for special files
# The $@ represents all possible files
for file in $(ls .)
do
		case "$file" in
				'vars') :; shift ;;
				'functions') :; shift ;;
				*) :; break ;;
		esac
done
