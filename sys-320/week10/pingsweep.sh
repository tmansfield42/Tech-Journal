read prefix

if [ ${#prefix} -lt 5 ]; then
echo 'must be larger than 5' 
else
for i in {1..254}
do
	ping -c 1 $prefix.$i | grep "bytes from" | grep -Eo 10.0.17.[0-9]+ 

done
fi
