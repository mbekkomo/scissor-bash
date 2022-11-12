#!/usr/bin/env bash

# Usage:
# scissor_repeat <string> <repn> [sep]
#
# Return:
# > string The repeated string
#
# =====================================
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
# Nameref:
# ~ array Nameref of the 1st argument
#
# =====================================
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
# Return:
# > string Trimmed string
#
# =====================================
# Trim spaces in string.
scissor_trim() {
	local string="$1"

	local trimmed_string
	trimmed_string="$(echo "$string" |
		sed -E "s/^[ ]+//g" |
		sed -E "s/[ ]+$//g")"

	echo "$trimmed_string"
}

# Usage:
# scissor_padleft <string> <final_len> [pattern=" "]
#
# Return:
# > string Padded string
#
# =====================================
# Add padding #final_len# to the left side of string.
# If "pattern" passed, it'll uses the value of $pattern
# instead " ".
scissor_padleft() {
	local string="$1"
	local final_len="$2"
	local pattern="${3:- }"

	echo "$(scissor_repeat "$pattern" $((( final_len - ${#string} ) / ${#pattern})))$string"
}

# Usage:
# scissor_padright <string> <final_len> [pattern=" "]
#
# Return:
# > string Padded string
#
# =====================================
# Add padding #final_len# to the right side of string.
# If "pattern" passed, it'll uses the value of $pattern
# instead " ".
scissor_padright() {
	local string="$1"
	local final_len="$2"
	local pattern="${3:- }"

	echo "$string$(scissor_repeat "$pattern" $((( final_len - ${#string} ) / ${#pattern})))"
}

# Usage:
# scissor_padmiddle <string> <final_len> [pattern=" "]
#
# Return:
# > string Padded string
#
# =====================================
# Add padding #final_len# to the both left and right side of string.
# If "pattern" passed, it'll uses the value of $pattern
# instead " ".
scissor_padmiddle() {
	local string="$1"
	local final_len="$2"
	local pattern="${3:- }"
	
	local pad;pad=$(scissor_repeat "$pattern" $((( final_len - ${#string} ) / ${#pattern})))
	echo "$pad$string$pad" 
}

# Usage:
# scissor_endswith <string> <match>
#
# Return:
# > exitcode The result of the function
#
# =====================================
# Check if $string is ends with $match
scissor_endswith() {
	local string="$1"
	local match="$2"

	if [[ $string =~ $match$ ]]; then
		return 0
	else
		return 1
	fi
}

# Usage:
# scissor_startswith <string> <match>
#
# Return:
# > exitcode The result of the function
#
# =====================================
# Check if $string starts with $match
scissor_startswith() {
	local string="$1"
	local match="$2"

	if [[ $string =~ ^$match ]]; then
		return 0
	else
		return 1
	fi
}

scissor_random() {
	local len="$1"
	local min_oct="${2:-040}"
	local max_oct="${3:-176}"

	local -a buff
	for _ in $(seq 1 "$len"); do
		local oct;oct=$(shuf -i "$min_oct-$max_oct" -n 1)
		if [[ ! $oct =~ ^00[1-9]$ ]]; then
			oct="00$oct"
		elif [[ ! $oct =~ ^0[1-9]\{2\}$ ]]; then
			oct="0$oct"
		fi
		buff+=("$(echo -e "\\$oct")")
	done

	echo "${buff[@]}"
}
