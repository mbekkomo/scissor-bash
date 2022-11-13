# scissor - String Manipulation library for Bash ✂

The purpose of the library is to add string manipulation functions into Bash which commonly present in other languages such as Ruby, JavaScript etc. If you ever want split, trim, pad and other functions, this library is perfect for you. ;)

## Installation
Via [`bpkg`](https://github.com/bpkg/bpkg):
```bash
bpkg install UrNightmaree/scissor-bash
```
Or just download and put `scissor.sh` into the root of your project.

## Usage
Source it in the code like in the example below:
```bash
# If you install Scissor trough `bpkg`
source deps/scissor-bash/scissor.sh
# If you manually install
source path/to/scissor.sh


# The namespace for Scissor is "scissor_"
printf "Tell me your name: "
read myname

myname="$(scissor_trim "$myname")"

if scissor_startswith "$myname" "scissor"; then
  echo "✂"
else
  echo "Hi $myname 👋"
fi
```

## API

### repeat \<string> \<n> [sep]
Repeats the string `n` times. If `sep` passed, it'll separate the repeated string with `sep` value
```bash
scissor_repeat "<>" 3 #=> "<><><>"
scissor_repeat "Gimme," 4 " " #=> "Gimme, Gimme, Gimme, Gimme,"
```

### split \<array> \<string> [del=" "]
Splits the string with `del` and put it into nameref `array`
```bash
declare -a split_str
declare -a split_str_withdel

scissor_split split_str "A B C" #=> (A B C)
scissor_split split_str_withdel "1_2-3" "_" #=> (1 "2-3")
```

### trim \<string> [pattern=" "]
Trims the string. If `pattern` passed, trims `pattern` in the string.
```bash
scissor_trim "  abc  #=> "abc"
scissor_trim "__underscore__" "_" #=> "underscore"
```
