#!/bin/sh

# 2017 Michael Gajda <draget@speciesm.net>
# See LICENSE for license information

USAGE="$0 <URL> <USER>:<PW> <DIR>"

# check parameter
: ${1?Please specify a WebDAV URL. Usage: $USAGE}
: ${2?Please specify a user and password. Usage: $USAGE}
: ${3?Please specify a directory. USAGE $USAGE}

# check path
case $3 in
/*|.*)
    echo "Please specify a relative subdirectory. Usage: $USAGE" ; exit 1 ;;
esac

# create dirs relative to current recursively
find $3 -type d ! -path . -exec curl --user $2 -X MKCOL $1/{} \;
# upload files recursively
find $3 -type f -exec curl --user $2 -T {} $1/{} \;
