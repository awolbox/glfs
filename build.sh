#!/bin/bash

_executive_=makesrc.sh
readonly torn_executive="$(printf '%s\n' "_$executive_" | cut -d "." -f 1)"
readonly script=".${torn_executive}"

# Special files handled
_vars()
{
		# First in ${torn_executive}
		if [ -f "vars" ];
		then
				# If vars exists, make $torn_execuitive
				touch $script; chmod 600 $script || return 1
				
				# If $torn_executive exists send vars
				# thus starting the "compilation"
				[ $? -eq 0 ] cat "vars" > ${script} || return 1
		else
				return 1
		fi
}

_functions()
{
		typeset -a all
		all=($@)
		
		while read -r line
		do
				for "$line" in "${all[@]}"
				do
						cat $(cut -d '"' -f 2) >> ${script} || return 1
				done
		done < "functions"
}

# Handle function return values
_handle()
{
		local return=$?
		
		if [ "$?" ];
		then
				case "$return" in 
						'0') return 0; break ;;
						'1') exit 1; break ;;
				esac
		fi
}



# Check current working directory for special files
for file in $(ls .)
do
		case "$file" in
				'vars') _vars; _handle; shift ;;
				'functions') _functions; _handle; shift ;;
				'--') shift; break ;;
				*) exit 1; break ;;
		esac
done

exit $?

