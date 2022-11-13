#!/usr/bin/env bash

. scissor.sh

str="   Hi Lua    "
echo "$str"
str="$(scissor_trim "$str")"

echo "$str"
echo "$(scissor_truncate "$str" 4 "...")"
