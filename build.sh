#!/bin/bash

#
# WARNING: This script will self destruct in 'EOF'
#

readonly rawman=${executive}.1.md
readonly color='\e[32m'
readonly reset='\e[0m'

# Setup a working directory
_setup()
{
		# Check if a working setup exists
		if [ -f functions ] && [ -f vars ];
		then
				return 1
		fi

		# Set native files, give an apropriate version number, and open $executive in an editor
		touch functions vars ${executive} || return 1
		echo "readonly VERSION=1.0" > vars || return 1
		echo "#!/bin/bash" > ${executive} && chmod +x ${executive} || return 1
		${editor} ${executive}
}

# Show variable information
_list_vars()
{
		#sed '/^\s*$/d'
		echo -e "${color}VARIABLES:${reset}"
		while read -r line
		do
				case $line in
						''|\#*) continue ;;
				esac
						echo "$(echo -e ${color} $(echo $line | cut -d "=" -f 1 | cut -d " " -f 2\
								) ${reset})$(echo $line | cut -d "=" -f 2 | sed 's/#.*//')"
		done < vars
}

# Show functions' "order of opertations"
_list_functions()
{
		echo -e "${color}FUNCTIONS:${reset}" && \
				while read -r line
				do 
						echo -e " ${color}(${n})${reset}\t$(echo $line | cut -d ' ' -f 2)";
						n=$(($n + 1))
				done < functions | sed '1 d' | sed '$ d'
}


# Native files handled
_vars()
{
		# Start if 'vars' exists
		cat $executive | head -n 1 > .vars && cat vars >> .vars || return 1
}

_functions()
{
		while read line
		do
				cat $(cut -d " " -f 2) > .funcs
		done < functions
		[ $? -ne 0 ] && { return 1; } ||  return 0
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
		sed -i '1,4 d' $executive
		cat $executive >> .vars && rm $executive
		mv .vars $executive && chmod +x $executive
		rm ./_*; rm vars functions
		[ $? -eq 0 ] && _special
}

# Return values handled
_returns()
{
		ret=$?
		while [ $? ]
		do case "$ret" in 
				0) exit 0 ;;
				1) echo "EXIT 1"; exit 1 ;;
		esac done
}

# "Compile"
# Checks to see if "native" files still exsist, if so, "merges" all files together in a certain order, then cleans up the place.
_compile()
{
		all_files=( $(ls .) )
		for n_file in ${all_files[@]}
		do case "$n_file" in
				vars) _vars; _returns ;;
				functions) _functions; _returns ;;
		esac done
		[ $? -eq 0 ] && { _sweep; } || return 1
}

# Options
options=$(getopt -o 'fn:v' -l 'funcs,name=:,vars' -- "$@")
[ $? -gt 0 ] && exit 1
eval set -- "$options"

if [ $# -eq 0 ]
then
		echo -n "[NAME]: "
		read executive
		_setup
fi

while [ $# -gt 0 ]
do
		case "$1" in
				'-n'|'--name=') executive=$2; _setup; returns; break ;;
				'-f'|'--funcs') _list_functions; _returns ;;
				'-v'|'--vars') _list_vars; _returns ;;
		esac
done

