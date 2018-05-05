#!/usr/bin/env bash

readonly VERSION='2.0'

# exit codes 
readonly EXIT_OK='0'				# completed without error
readonly EXIT_USAGE='64'			# error - general command line usage error 
readonly EXIT_DATAERROR='65'		# error - corrupt data (.sig, checksums, etc.)
readonly EXIT_NOHOST='68'			# error - source get failed
readonly EXIT_UNAVAILABLE='69'		# error - improper input - (SRCBUILD not found)
readonly EXIT_NOPERM='70'			# error - improper permissions - (root permissions needed)
readonly EXIT_CANTCREATE='73'		# error - makesrc failed - cannot build source

# permissions/security
readonly _UID="$(id -u "$USER")"
readonly _GID="$(id -g "$USER")"

# color values
readonly bold='\e[1m'
readonly reset='\e[0m'
readonly red='\e[31m'
readonly green='\e[32m'
readonly yellow='\e[33m'
readonly blue='\e[34m'
readonly magenta='\e[35m'
readonly bold_red=${bold}${red}
readonly bold_green=${bold}${green}
readonly bold_yellow=${bold}${yellow}
readonly bold_blue=${bold}${blue}
readonly bold_magenta=${bold}${magenta}

# uix
_message() { [ $QUIET = 0 ] && echo -e "${bold_green} * ${reset}${*}" >&2; }
_warning() { [ $QUIET = 0 ] && echo -e "${bold_yellow} [W] ${reset}${*}" >&2; }
_error() { [ $QUIET = 0 ] && echo -e "${bold_red} [X] ${reset}${*}" >&2; }
_die() { [ $QUIET = 0 ] && { _error "Fatal error - ${@}" && exit $_EX; } || exit $_EX; }

# Functions
source "_tmp_space"
source "_version"
source "_usage"
source "_usage_error"
source "_has_user_config"
source "_has_keyring"
source "_repositories"
source "_read_SRCBUILD"
source "_has_dependencies"
source "_get_dependencies"
source "_get_source"
source "_source_verify"
source "_source_extract"
source "cmd_get_info"
source "cmd_makesrc"

#### FILE DELIMETER #### - !! DO NOT DELETE THIS LINE !! - ####
