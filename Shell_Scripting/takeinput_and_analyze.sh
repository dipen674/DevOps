#!/bin/bash
read -p "Please enter a numnber that you want to check :::" A
if [ $A -eq 5 ]; then
	echo "$A is equals to 5"
elif [ $A -lt 5 ]; then
	echo "$A is less than 5"
else
	echo "$A is greater than 5"
fi

