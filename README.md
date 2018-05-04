% MAKESRC(1)  Makesrc Users Manual
% awol <awol@member.fsf.org>
% May 2018

# NAME

makesrc - build source using a SRCBUILD

# SYNOPSIS

makesrc [Options]... [Arguments]... SRCBUILD

# DESCRIPTION

	   ::
	   ::
	   ::

# NOTES

uses: echo, cat parted, tar, and more.
(nothing fancy, unfinished, needs more work!)

# OPTIONS

-c *CONFIG*, \--config *CONFIG
:	If this option is set, then *CONFIG* is the absolute path to a valid config file must be specified WITHIN PARENTHESIS 
	(ex. ""), Otherwise a fatal error will occur and the program exits with a return value. If a config file is specified, all 
	variables will be checked and if the config file is considered "valid", it will be used. If not the program exits 
	with another fatal error.

-h, --help
:	Show help and usage information.

-v, --version 
:	Show version information.

-s, --silent
:	Do not promt the user for anything. Automatically installs needed dependencies, also disables all output from STDOUT.
	In which case, one would have to check the return value -- ex. 'echo $?'. See *EXIT STATUS* for more information.

-i, --info
:	Queries the SRCBUILD file inside of a working directory, then sends various information to STDOUT.

-x *CC_TOOLCHAIN*, --cc *CC_TOOLCHIAN*
:	Instructs makesrc to cross-compile a new working toolchain using *CC_TOOLCHAIN* options. see

# CC_TOOLCHAIN OPTIONS

\--cc-dev *DEVICE*
:	Cross-compilition device. *DEVICE* equals the device name to build upon ( using "device labels" - Ex. /dev/sdx ).

\--cc-dir *DIR*
:	Cross-compilation directory. *DIR* is the absolute path to the device mounted on the host system.

\--cc-wipe *WIPE*
:	Erase disk before build. Valid *WIPE* options include: zeros - '0', random data - '1', or both, one after the other.

\--cc-boot *BOOT*
:	Sets a boot flag type for new *CC_TOOLCHAIN*. *BOOT* Values can be either 'mbr' for mbr/gpt boot, and 'uefi' for efi/gpt.
	
\--cc-part *PARTS*
:	Partition new disk.

\--cc-tgt-name *TGT_NAME*
:	Sets a new target name for *CC_TOOLCHAIN*. This is needed, but not necessary for the user to do, as this will default to
	'cc-linux-gnu'. All *TGT_NAME* names will be prefixed by system architecture (ex, x86_64-). You will not need to Know this,
	and you will not need to set this manually, but you can.

\--cctc-name *CC_TOOLCHAIN_NAME*
:	Name all working dirs/links/temp_users after *CC_TOOLCHAIN_NAME*.

# ENVIRONMENT

CCTC_TBX,
CCTC_USR,
CCTC_DIR,\
TGTBUILD_DEV,
TGTBUILD_DIR,
TGTBUILD_TGT,\
SOURCE_DIR,
SOURCE_GET,
SOURCE_KEYRING,

# EXIT STATUS

EXIT_OK,
EXIT_USAGE,
EXIT_UNAVAILABLE,
EXIT_NOPERM,
EXIT_DATAERR,
EXIT_NOHOST,
EXIT_CANTCREATE,

# SEE ALSO
 
gnu/linux-from-scratch <https://linuxfromscratch.org>, gnu <https://gnu.org>, fsf <https://fsf.org>

