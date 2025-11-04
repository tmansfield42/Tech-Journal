file="/var/log/apache2/access.log"

function pageCount(){

 info=$(sudo cat "$file" | cut -d' ' -f7)
}

pageCount

sudo sort <<< "$info" | uniq -c
