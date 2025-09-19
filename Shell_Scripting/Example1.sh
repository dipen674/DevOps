#/bin/bash
echo " example 1"
echo "Printing simple message using echo"

echo "----------------------Basic Arithmetic---------------------------------------------------"
a=5
b=3
echo "sum = $((a+b))"
echo "product = $((a*b))"
echo "With expr"
expr $a + $b
echo "-----------------Conditional Statements----------------------------------------------------------------------"
echo "If statement"
if [ $a -gt $b ]; then
 echo "$a is greater"
fi
echo "----------If-Else---------------"
if [ $a -gt $b ]; then
 echo "a > b"
else
echo "b >= a"
fi
echo "----------iIf-ElseIf-Else (elif)-----------------"
if [ $a -gt $b ]; then
 echo "a > b"
elif [ $a -lt $b ]; then
echo "a < b"
else
echo "a == b"
fi
echo "------------String comparision----------------"
str1=dipendra
str2=dipen
if [ "$str1" = "$str2" ]; then
 echo "Strings are equal"
else
echo "Strings are not equal"
fi
echo "-------------------Loops in Shells---------------------------"
echo "-------------For Loop---------"
for i in 1 2 3 4 5
do
 echo $i
done
echo "----------------While Loop----------------"
i=1
while [ $i -le 5 ]
do
 echo $i
((i++))
done
echo "--------------Until Loop-------------------"
i=1
until [ $i -gt 5 ]
do
 echo $i
((i++))
done
echo "-------------------------------Arrays in Shell--------------------------"
echo "--------------------Define and Access---------------"
fruits=("apple" "banana" "cherry")
echo ${fruits[0]} # apple
echo ${fruits[@]} # all
echo ${#fruits[@]} # count
echo "-------------Loop Through Array-------------"
for item in "${fruits[@]}"
do
 echo $item
done
echo "----------Case Statement (Switch-like)----------"
read -p "Enter a number: " num
case $num in
 1) echo "One";;
2) echo "Two";;
*) echo "Unknown";;
 *) echo "Unknown";;
esac

echo "-------------------Functions---------------"
greet() {
 echo "Hello, $1 $2"
}
greet "Ravi shyam" 
#"Note $1,$2 are positional parameters"
#
