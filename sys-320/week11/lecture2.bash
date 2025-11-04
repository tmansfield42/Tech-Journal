file="/var/log/apache2/access.log"

function pageCount(){

 info=$(sudo cat "$file" | grep "curl" | cut -d' ' -f1,12)
}

pageCount

sudo sort <<< "$info" | uniq -c
