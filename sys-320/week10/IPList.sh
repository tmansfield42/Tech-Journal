read prefix

if [ ${#prefix} -lt 5 ]; then
echo 'must be larger than 5' 
else
for i in {1..254}
do
	echo "$prefix.$i"

done
fi
