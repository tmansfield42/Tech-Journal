doc="cassignment.html"


cat "$doc" | grep "<td>" | tr -d '<td>' | sed 's/\/$//' | paste - - | uniq | awk '{ keys[$2] = keys[$2] " " $1 } END { for (v in keys) print keys[v], v }' | sort -n 
