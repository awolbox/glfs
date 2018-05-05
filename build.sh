#!/bin/bash
_executive_=makesrc.sh

readonly torn_executive="$(printf '%s\n' "_$executive_" | cut -d "." -f 1)"

# Handle vars
# Handle functions

z=($@)
for y in $(ls .)
do
		case "$z" in
				'vars') :; shift ;;
				'functions') :; shift ;;
				*) :; break ;;
		esac
		
		# defaults
		#cat ./_* >> .${script}
done
