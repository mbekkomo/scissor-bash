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

### charindex \<string> \<index>
Get char with index `index` from string.
```bash
scissor_charindex "Hmm" 1 #=> "H"
scissor_charindex "Hi $(whoami)!" 3 #=> " "
```

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

### padleft \<string> \<len> [pattern=" "]
Pads the string on the left side with `len`. If `pattern` passed, pad with `pattern`.
```bash
scissor_padleft "woosh" 3 #=> "   woosh"
scissor_padleft "1222333" 2 "1" #=> "111222333"
```

### padmiddle \<string> \<len> [pattern=" "]
Pads the string on the left and right side with `len`. If `pattern` passed, pad with `pattern`.
```bash
scissor_padmiddle "empty" 3 #=> "   empty   "
scissor_padmiddle "BAR" 2 "!" #=> "!!BAR!!"
```

### padright \<string> \<len> [pattern=" "]
Pads the string on the right side with `len`. If `pattern` passed, pad with `pattern`.
```bash
scissor_padright "woah" 3 #=> "woah   "
scissor_padright "Shocked" 2 "!" #=> "Shocked!!"
```

### trim \<string> [pattern=" "]
Trims the string. If `pattern` passed, trims `pattern` in the string.
```bash
scissor_trim "  abc  " #=> "abc"
scissor_trim "__underscore__" "_" #=> "underscore"
```

### trimleft \<string> [pattern=" "]
Trims the string on the left side. If `pattern` passed, trims `pattern` in the string.
```bash
scissor_trim "  bash  " #=> "bash  "
scissor_trim "!!foo!!" "!" #=> "foo!!"
```

### trimright \<string> [pattern=" "]
Trims the string on the right side. If `pattern` passed, trims `pattern` in the string.
```bash
scissor_trim "  abc  " #=> "abc"
scissor_trim "__underscore__" "_" #=> "underscore"
```

### truncate \<string> \<len> [suffix]
Truncates a string `len` times. If `suffix` passed, at `suffix` at the end of the truncated string.
```bash
scissor_truncate "number" 3
scissor_truncate "lorem ipsum dolor sit amet" 10 "..." #=> "lorem ipsum..."
```

### endswith \<string> \<match>
Return `0` if string matched with `match` at the end, otherwise `1`.
```bash
if scissor_endswith "bash" "sh"; then
  echo "It's Bash!"
fi
```

### startswith \<string> \<match>
Return `0` if string matched with `match` at the start, otherwise `1`.
```bash
if ! scissor_startswith "zsh" "ba"; then
  echo "It's not Bash, it's Zsh!"
fi
```
