


# Detailed Reference

NAME="John"
echo $NAME
echo "$NAME"
echo "${NAME}!"

cho "I'm in $(pwd)"
echo "I'm in `pwd`"

# Functions
myfunc() {
    local myresult='some value'
    echo $myresult
}
result=$(myfunc)
myfunc() {
    echo "hello $1"
}

# Same as above (alternate syntax)
function myfunc() {
    echo "hello $1"
    $#	# Number of arguments
	$*	# All arguments
	$@	# All arguments, starting from first
	$1	# First argument
}
myfunc "John"

# Regex
if [[ "A" =~ "." ]]

# Default Values
${FOO:=val}	# Set $FOO to val if not set
${FOO:?message}	# Show error message and exit if $FOO is not set

# Loops
for i in /etc/rc.*; do
  echo $i
done
while true; do
  ···
done
cat file.txt | while read line; do
  echo $line
done

for i in {5..50..5}; do
    echo "Welcome $i"
done

# Errors
if myfunc; then
  echo "success"
else
  echo "failure"
fi

# Conditions
[ -z STRING ]	Empty string
[ -n STRING ]	Not empty string
[ NUM -eq NUM ]	Equal
[ NUM -ne NUM ]	Not equal
[ NUM -lt NUM ]	Less than
[ NUM -le NUM ]	Less than or equal
[ NUM -gt NUM ]	Greater than
[ NUM -ge NUM ]	Greater than or equal
[[ STRING =~ STRING ]]	Regexp
(( NUM < NUM ))	Numeric conditions
[ -o noclobber ]	If OPTIONNAME is enabled
[ ! EXPR ]	Not
[ X ] && [ Y ]	And
[ X ] || [ Y ]	Or

# File Conditions
[ -e FILE ]	Exists
[ -r FILE ]	Readable
[ -h FILE ]	Symlink
[ -d FILE ]	Directory
[ -w FILE ]	Writable
[ -s FILE ]	Size is > 0 bytes
[ -f FILE ]	File
[ -x FILE ]	Executable
[ FILE1 -nt FILE2 ]	1 is more recent than 2
[ FILE1 -ot FILE2 ]	2 is more recent than 1
[ FILE1 -ef FILE2 ]	Same files

# Conditional Examples:
# String
if [ -z "$string" ]; then
  echo "String is empty"
elif [ -n "$string" ]; then
  echo "String is not empty"
fi
# Combinations
if [ X ] && [ Y ]; then
  ...
fi
# Regex
if [[ "A" =~ "." ]]
if (( $a < $b ))
if [ -e "file.txt" ]; then
  echo "file exists"
fi


# Defining Arrays
Fruits=('Apple' 'Banana' 'Orange')
Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"

# Working w/ arrays
echo ${Fruits[0]}           # Element #0
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)

# Array Operations
Fruits=("${Fruits[@]}" "Watermelon")    # Push
Fruits=( ${Fruits[@]/Ap*/} )            # Remove by regex match
unset Fruits[2]                         # Remove one item
Fruits=("${Fruits[@]}")                 # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
lines=(`cat "logfile"`)                 # Read from file

# Arrays Iteration
for i in "${arrayName[@]}"; do
  echo $i
done


# Mumeric Calculations 
$((a + 200))      # Add 200 to $a
$((RANDOM%=200))  # Random number 0..200

# Getting Options
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $version
    exit
    ;;
  -s | --string )
    shift; string=$1
    ;;
  -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

# Redirection
python hello.py > output.txt   # stdout to (file)
python hello.py >> output.txt  # stdout to (file), append
python hello.py 2> error.log   # stderr to (file)
python hello.py 2>&1           # stderr to stdout
python hello.py 2>/dev/null    # stderr to (null)
python hello.py &>/dev/null    # stdout and stderr to (null)
python hello.py < foo.txt

# Reading Input
echo -n "Proceed? [y/n]: "
read ans
echo $ans
read -n 1 ans    # Just one character

# Directory of Script
DIR="${0%/*}"

# Special
$?	Exit status of last task
$!	PID of last background task
$$	PID of shell

# Expansion
!$	Expand last parameter of most recent command
!*	Expand all parameters of most recent command
!-n	Expand nth most recent command
!n	Expand nth command in history
!<command>	Expand most recent invocation of command <command>

# Operations
!!:s/<FROM>/<TO>/	Replace first occurrence of <FROM> to <TO> in most recent command
!!:gs/<FROM>/<TO>/	Replace all occurrences of <FROM> to <TO> in most recent command
!$:t	Expand only basename from last parameter of most recent command
!$:h	Expand only directory from last parameter of most recent command