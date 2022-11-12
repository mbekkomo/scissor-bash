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
# $del will be splitted.
scissor_split() {
	local -n _Array="${1:?argument #1 is empty!}"
	local string="${2:?argument #2 is empty!}"
	local del="${3:- }"

	for s in ${string//$del/ }; do
		_Array+=("$s")
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
	local string="${1:?argument #1 is empty!}"

	local trimmed_string
	trimmed_string="$(sed -E "s/^[ ]+//g;s/[ ]+$//g" <<< "$string")"

	echo "$trimmed_string"
}

# Usage:
# scissor_trimleft <string>
#
# Return:
# > string Trimmed string
#
# =====================================
# Trim spaces in the left side of the string.
scissor_trimleft() {
	local string="${1:?argument #1 is empty!}"

	local trimmed_string
	trimmed_string="$(sed -E "s/^[ ]+//g" <<< "$string")"

	echo "$trimmed_string"
}

# Usage:
# scissor_trimright <string>
#
# Return:
# > string Trimmed string
#
# =====================================
# Trim spaces in the right side of the string.
scissor_trimright() {
	local string="${1:?argument  #1 is empty!}"

	local trimmed_string
	trimmed_string="$(sed -E "s/[ ]+$//g" <<< "$string")"

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
	local string="${1:?argument #1 is empty!}"
	local final_len="${2:?argument #2 is empty!}"
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
	local string="${1:?argument #1 is empty!}"
	local final_len="${2:?argument #2 is empty!}"
	local pattern="${3:- }"

	echo "$string$(scissor_repeat "$pattern" $(( ( final_len - ${#string} ) / ${#pattern} )) )"
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
	local string="${1:?argument #1 is empty!}"
	local final_len="${2:?argument #2 is empty!}"
	local pattern="${3:- }"
	
	local pad;pad=$(scissor_repeat "$pattern" $(( ( final_len - ${#string} ) / ${#pattern})) )
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

scissor_charindex() {
	local string="${1:?argument #1 is empty!}"
	local index="${2:-1}"

	string=$(sed -E "s/[ ]+/\*/g" <<< "$string")
	for i in $(seq 1 "${#string}"); do
		string="$(sed -E "s/(.{$i})/\1 /g" <<< "$string")"
	done

	local -a buff
	local -i i=1
	echo $string
	for s in $string; do
		buff[$i]="${s//*/ }"
		i+=1
	done

	echo "${buff[$index]}"
}
