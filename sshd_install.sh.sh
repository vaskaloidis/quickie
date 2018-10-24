#!/bin/bash
# Author:       <%= @user %>
# Email:        <%= @email %>
# Date:         <%= @date %>
# Usage:        <%= @name %>.sh
# Description:  A short application summary.

usage <<END
<%= @name %> - Summary in one sentence.
Usage:
      <%= @name %>.sh -ab -c=PARAM
				      -?|h
-a 				does THIS
-b 				Instead does THIS!
-c=PARAM 		INSTEAD does this!!!
-h|-?			Display Usage
END

OPTIND=1 #POSIX

PARAM=""
PARAM=0

# <%= @name %> in one sentence.sh -h?abc
while getopts "h?abc:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    a)  CHOSEN=1
        ;;
    b)  CHOSEN=2
        ;;
    c)  PARAM=$PARAM
		CHOSEN=3
        ;;
    esac
done

# Validation? TODO: Find out.
shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift

echo "Params: chosen=$CHOSEN, param='$PARAM', Leftovers: $@"

# Same as above (alternate syntax)
function show_help() {
    echo "$USAGE"
}
