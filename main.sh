#!/usr/bin/env bash

. scissor.sh

str="   Hi Lua    "
echo "$str"
str="$(scissor_trim "$str")"

echo "$str"
echo "$(scissor_truncate "$str" 4 "...")"

str="Hi <3"
for i in $(seq 1 "${#str}"); do
	scissor_charindex "$str" "$i"
done
