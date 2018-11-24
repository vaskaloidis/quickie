

if [ -z "$string" ]; then
  echo "String is empty"
elif [ -n "$string" ]; then
  echo "String is not empty"
fi

if [ ! -z $1} ]; then 
	ssh vasili@Ares
elif [ -z $1} ]; then 
	ssh vasili@Ares $1
fi


NAME="John"
echo $NAME
echo "$NAME"

cho "I'm in $(pwd)"

# Regex
if [[ "A" =~ "." ]]

# Functions
myfunc() {
    echo "hello $1"
    local myresult='some value'
    echo $myresult
}
result=$(myfunc)

# User Input
read -p "Enter Description: " desc

# Get Yes/no Proceed user input
read -p "Continue (y/n)?" choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) 
	echo "no"
	exit 0
	;;
  * ) echo "invalid";;
esac