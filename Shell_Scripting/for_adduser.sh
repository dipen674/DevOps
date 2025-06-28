for x in ram shyam hari
do
	echo "Adding user $x"
	sudo useradd $x
	id $x
	sleep 4s
done 


