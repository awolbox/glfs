#!/bin/bash

#
# WARNING: This script will self destruct in 'EOF'
#

executive=makesrc
rawman=${executive}.1.md
color='\e[32m'
reset='\e[0m'

# Variable values
_var_values()
{
		#sed '/^\s*$/d'
		echo -e "${color}VARIABLES:${reset}"
		while read -r line
		do
				case $line in
						''|\#*) continue ;;
				esac
						echo "$(echo -e ${color} $(echo $line | cut -d "=" -f 1 | cut -d " " -f 2) ${reset})$(echo $line | cut -d "=" -f 2 | sed 's/#.*//')"
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

while [ $# -gt 0 ];
do
		case "$1" in
				'-f') _list_functions; exit $? ;;
				'-v') _var_values; exit $? ;;
		esac
done

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
		sed -i '1,4 d' $executive
		cat $executive >> .vars && rm $executive
		mv .vars $executive && chmod +x $executive
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


