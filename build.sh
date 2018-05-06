#!/bin/bash

#
# This script will self destruct
#

exe=makesrc
rawman=${exe}.1.md

# Native files handled
_vars()
{
		# Start if 'vars' exists
		cat $exe | head -n 1 > .vars && cat vars >> .vars || return 1
}

_functions()
{
		while read line
		do
				cat $(cut -d " " -f 2) > .funcs
		done < functions
		if [ $? -ne 0 ];
		then
				return 1
		else
				return 0
		fi
}

# Return values handled
_returns()
{
		ret=$?
		if [ $? ];
		then
				case "$ret" in 
						0) return 0 ;;
						1) echo "EXIT 1"; exit 1 ;;
				esac
		fi
}

# Special files handled
self=$(basename $0)
_special()
{
		local found
		for found in ${all_files[@]}
		do
				case "$found" in
						"$rawman") rm "$rawman" || return 1 ;;
						"$self" ) rm "$self" || return 1 ;;
				esac
		done
}

# Finish him
_sweep()
{
		cat .funcs >> .vars && rm .funcs
		sed -i '1,4 d' $exe
		cat $exe >> .vars && rm $exe
		mv .vars $exe && chmod +x $exe 
		rm ./_*; rm vars functions
		[ $? -eq 0 ] && _special
}

# "Compile"
all_files=( $(ls .) )
for n_file in ${all_files[@]}
do
		case "$n_file" in
				vars) _vars; _returns ;;
				functions) _functions; _returns ;;
		esac
done

[ $? -eq 0 ] && { _sweep; }
exit $?

