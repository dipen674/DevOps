#!/bin/bash

# Create file with content
cat <<EOF > myfile.txt
Hello
I am practicing shell scripting
EOF

# Read file line by line
while read line
do
    echo "$line"
done < myfile.txt

echo "-------------------"

# Check if file exists
if [ -f myfile.txt ]; then
    echo "File exists"
else
    echo "File doesn't exist"
fi

#File exists -f filename
#Dir exists -d dirname
#Null string -z "$var"
#Non-empty -n "$var"

