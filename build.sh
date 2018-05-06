#!/bin/bash

executive='makesrc.sh'
readonly torn_executive="$(echo "${executive}" | cut -d "." -f 1)"
readonly script=".${torn_executive}"

# Native files handled
_vars()
{
		# Start if 'vars' exists
		touch ${script} || return 1
				
		# If $torn_executive exists, cat 'vars' to $script, thus starting "compilation"
		cat vars > ${script} && rm vars || return 1
}

_functions()
{
		local line
		
		while read line
		do
				cat $(cut -d '"' -f 2) >> ${script}
		done < 'functions'

		if [ $? -eq 0 ]
		then
				{ cat ${torn_executive} >> ${script} && rm -v ${torn_executive}; } || return 1
		else
				return 1
		fi
}

# Return values handled
_returns()
{
		ret=$?
		if [ "$ret" -ne 0 ]
		then
				case "$ret" in 
						'1') exit 1 ;;
				esac
		fi
}

# Special files handled
#special=()
_special()
{
		:
}

# Clean up
_sweep()
{
		mv ${script} ${executive}
		chmod +x ${executive}
		rm -v ./_*
}

# Check current working directory for special files
files=$(ls .)
for file in "$files"
do
		case "$file" in
				'vars') _vars; _returns ;;
				'functions') _functions; _returns ;;
				#"${special[@]}") : ;;
		esac
done

[ $? -eq 0 ] && { _sweep; }
exit $?


