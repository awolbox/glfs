#!/bin/bash

executive='makesrc.sh'
readonly torn_executive="$(printf '%s\n' "${executive}" | cut -d "." -f 1)"
readonly script=".${torn_executive}"

# Native files handled
_vars()
{
		# Start if 'vars' exists
		touch -v "${script}" && chmod 600 "${script}" || return 1
				
		# If $torn_executive exists, cat 'vars' to $script, thus starting "compilation"
		cat 'vars' > "${script}" && rm -v 'vars' || return 1
}

_functions()
{
		local line
		
		while read -r line
		do
				cat $(cat ${line} | cut -d '"' -f 2) >> ${script} || return 1
		done < 'functions'

		cat "${torn_executive}" >> "${script}" && rm -v "${torn_executive}" || return 1
}

# Return values handled
_returns()
{
		ret=$?
		while [ $? -ne 0 ]
		do
				case "$ret" in 
						'1') exit 1; break ;;
				esac
		done
}

# Clean up
_sweep()
{
		mv -v ${script} ${executive}
		chmod 700 ${executive}
		rm -v ./*_
}

# Check current working directory for special files
files=$(ls .)
for file in "$files"
do
		case "$file" in
				'vars') _vars; _returns ;;
				'functions') _functions; _returns ;;
				"${special[@]}") : ;;
		esac; _finish
done
exit $?

