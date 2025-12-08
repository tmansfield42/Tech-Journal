report="report.txt"
site="/var/www/html"

{
echo "<html>"
echo "<body>"
echo "<p>Access logs with IOC indicators:</p>"
echo "<table border='1'>"

while read -r line; do
    echo "<tr><td>${line// /</td><td>}</td></tr>"
done < "$report"

echo "</table>"
echo "</body>"
echo "</html>"
} > "report.html"

sudo mv "report.html" $site/
