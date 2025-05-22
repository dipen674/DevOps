
#!/bin/bash

echo "We are learning different positional argument and their cases in this script"
echo
echo "This is the 1st positiion argument $1"
echo
echo "this is the 2nd position argumen $2"
echo
echo "THis is 3rd posotion argument $3"
echo
echo " THis is the 4th position argument $4"
echo 
echo
echo "These aare the total no of arguments that are passed $$"
echo
echo "THese are the total no of commands that are passed with the count of them $#"
echo
echo "These are the list of arguments that are passed"
echo
echo "This the hosname of this machine $HOSTNAME "
echo
a=$(hostname) 
echo "$a"
echo "Host is printed successfully"
echo
echo "This is the username of this machine $USER"
echo
echo "This is the command that i am not sure of $?"
echo date
echo "date"
echo
echo "This is the random number generated $RANDOM and $random"
echo
sleep 5s
echo "THis is the $LINENO"
echo
echo "Thank you for waiting 5s"
echo
echo "The total time taken for this execution is $SECONDS"
echo
echo "This is the line number that we are currently in $LINENO" 

