#!/bin/bash

exe=makesrc

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
				cat $(cut -d '"' -f 2) > .vars
		done < functions
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

_finish()
{
		#cat .funcs >> .vars && rm .funcs
		sed -i '1,4 d' $exe
		cat $exe >> .vars && rm $exe
		mv .vars $exe && chmod +x $exe 
		#rm ./_*
}

all_files=( $(ls .) )
for n_file in ${all_files[@]}
do
		case "$n_file" in
				vars) _vars; _returns ;;
				functions) _functions; _returns ;;
		esac
done

[ $? -eq 0 ] && { _finish; _returns; }
exit $?

