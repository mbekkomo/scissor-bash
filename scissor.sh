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
	local string="${1:?argument #1 is empty!}"
	local repeat_number="${2:?argument #2 is empty!}"
	local separator="${3:-}"

	local repeated_string
	for U_ in $(seq 0 "$repeat_number"); do
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
# $del will be split.
scissor_split() {
	local -n _Array="${1:?argument #1 is empty!}"
	local string="${2:?argument #2 is empty!}"
	local del="${3:- }"

	for s in ${string//$del/ }; do
		_Array+=("$s")
	done
}

# Usage:
# scissor_trim <string> [pattern=" "]
#
# Return:
# > string Trimmed string
#
# =====================================
# Trim spaces in string.
scissor_trim() {
	local string="${1:?argument #1 is empty!}"
	local pattern="${2:- }"

	local trimmed_string
	trimmed_string="$(sed -E "s/^[$pattern]+//g;s/[$pattern]+$//g" <<< "$string")"

	echo "$trimmed_string"
}

# Usage:
# scissor_trimleft <string> [pattern=" "]
#
# Return:
# > string Trimmed string
#
# =====================================
# Trim spaces in the left side of the string.
scissor_trimleft() {
	local string="${1:?argument #1 is empty!}"
	local pattern="${2:- }"

	local trimmed_string
	trimmed_string="$(sed -E "s/^[$pattern]+//g" <<< "$string")"

	echo "$trimmed_string"
}

# Usage:
# scissor_trimright <string> [pattern=" "]
#
# Return:
# > string Trimmed string
#
# =====================================
# Trim spaces in the right side of the string.
scissor_trimright() {
	local string="${1:?argument  #1 is empty!}"
	local pattern="${2:- }"

	local trimmed_string
	trimmed_string="$(sed -E "s/[$pattern]+$//g" <<< "$string")"

	echo "$trimmed_string"
}

# Usage:
# scissor_padleft <string> <len> [pattern=" "]
#
# Return:
# > string Padded string
#
# =====================================
# Add padding #len# to the left side of string.
# If "pattern" passed, it'll uses the value of $pattern
# instead " ".
scissor_padleft() {
	local string="${1:?argument #1 is empty!}"
	local len="${2:?argument #2 is empty!}"
	local pattern="${3:- }"

	echo "$(scissor_repeat "$pattern" $((( len - ${#string} ) / ${#pattern})))$string"
}

# Usage:
# scissor_padright <string> <len> [pattern=" "]
#
# Return:
# > string Padded string
#
# =====================================
# Add padding #len# to the right side of string.
# If "pattern" passed, it'll uses the value of $pattern
# instead " ".
scissor_padright() {
	local string="${1:?argument #1 is empty!}"
	local len="${2:?argument #2 is empty!}"
	local pattern="${3:- }"

	echo "$string$(scissor_repeat "$pattern" $(( ( len - ${#string} ) / ${#pattern} )) )"
}

# Usage:
# scissor_padmiddle <string> <len> [pattern=" "]
#
# Return:
# > string Padded string
#
# =====================================
# Add padding #len# to the both left and right side of string.
# If "pattern" passed, it'll uses the value of $pattern
# instead " ".
scissor_padmiddle() {
	local string="${1:?argument #1 is empty!}"
	local len="${2:?argument #2 is empty!}"
	local pattern="${3:- }"
	
	local pad;pad=$(scissor_repeat "$pattern" $(( ( len - ${#string} ) / ${#pattern})) )
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
	local string="${1:?argument #1 is empty!}"
	local match="${2:?argument #2 is empty!}"

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
	local string="${1:?argument #1 is empty!}"
	local match="${2:?argument #2 is empty!}"

	if [[ $string =~ ^$match ]]; then
		return 0
	else
		return 1
	fi
}

# Usage:
# scissor_charindex <string> <index>
#
# Return:
# > string The index value (char) of string
#
# =====================================
# Getting the char index in string, much
# like Ruby's string index.
scissor_charindex() {
	local string="${1:?argument #1 is empty!}"
	local index="${2:?argument #2 is empty!}"

	string=$(sed -E "s/[ ]+//g" <<< "$string")
	for i in $(seq 1 "${#string}"); do
		string="$(sed -E "s/(.{$i})/\1 /g" <<< "$string")"
	done

	local -a buff
	local -i i=1
	local -i space_occur=1
	for s in $string; do
		if [[ $s = '' && $space_occur -eq 1 || $s = '' && $space_occur -eq 2 ]]; then
			space_occur+=1
		elif [[ $s = '' && $space_occur -eq 3 ]]; then
			buff[$i]=" "
			space_occur=1
			i+=1
		else
			buff[$i]="$s"
			i+=1
		fi
	done

	echo "${buff[$index]}"
}

# Usage:
# scissor_truncate <string> <len> [suffix]
#
# Return:
# > string Truncated string (with suffix if
#  "suffix" passed)
#
# =====================================
# Truncates string to a specified length,
# add suffix if "suffix" passed.
scissor_truncate() {
	local string="${1:?argument #1 is empty!}"
	local len="${2:?argument #2 is empty!}"
	local suffix="${3:-}"

	local truncate_string
	truncate_string="$(sed -E "s/.{$len}$//g" <<< "$string")"

	echo "$truncate_string$suffix"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	echo "MUST BE IN SCRIPT OR \"source scissor.sh\"!" >&2
	exit 1
fi
