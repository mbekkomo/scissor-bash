#!/usr/bin/env bash

# Usage:
# scissor_repeat <string> <repn> [sep]
#
# Details:
# Repeat a string #repn# times. If "sep" passed,
# repeated string will be separated with $sep value.
scissor_repeat() {
	local string="$1"
	local repeat_number="$2"
	local separator="${3:-}"
	
	local repeated_string
	for _ in $(seq 0 "$repeat_number"); do
		repeated_string="${string}${separator}${string}"
	done
	repeated_string="${repeated_string}${separator}${string}"

	echo "$repeated_string"
}

# Usage:
# scissor_split <array> <string> [del=" "]
#
# Details:
# Split a string into array and put it into
# nameref $array. If "del" passed, string containing
# $del will be splitted.
scissor_split() {
	local -n array="$1"
	local string="$2"
	local del="${3:- }"

	for s in $(sed "s/$del/ /g" <<< $string); do
		array+=("$s")
	done
}

# Usage:
# scissor_trim <string>
#
# Details:
# Trim spaces in string.
scissor_trim() {
	local string="$1"
	
	local trimmed_string
	trimmed_string="$(echo "$string" |
										sed -E "s/^[ ]+//g" |
										sed -E "s/[ ]+$//g")"

	echo "$trimmed_string"
}

scissor_padleft() {
	local string="$1"
	local final_len="$2"
	local pattern="${3:- }"

	echo "$(scissor_repeat "$pattern" $((( final_len - ${#string}) / ${#pattern})))$string"
}
