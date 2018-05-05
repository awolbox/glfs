#!/bin/bash
_executive_=makesrc.sh

readonly torn_executive="$(printf '%s\n' "_$executive_" | cut -d "." -f 1)"


handle_vars()
{
		all=($@)
		while read line
		do
				for line in "$all"
				do
		done <-""
}
handle_functions

# Handle the order of operations
ooo()
{
		:
}

z=($@)
for y in $(ls .)
do
		case "$z" in
				'vars') :; shift ;;
				'functions') :; shift ;;
				"_${y}") ooo; break ;;
				*) :; break ;;
		esac
		
		# defaults
		#cat ./_* >> .${script}
done
