function classes{
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.16/Courses2025FA.html
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")
$table = @()
    for($i=1; $i -lt $trs.length; $i++){
    $tds = $trs[$i].getElementsByTagName("td")
    $times = $tds[5].innerText.Split("-")
  
    $table += [PSCustomObject]@{"Class Code" = $tds[0].innerText;
                                "Title" = $tds[1].innerText;
                                "Days"  = $tds[4].innerText
                                "Time_start" = $Times[0];
                                "Time_end" = $Times[1]
                                "Instructor" = $tds[6].innerText;
                                "Location" = $tds[9].innerText;
                                }

}
$table = translate($table)
return $table
}

function translate($table){


for($i=0; $i -lt $table.length; $i++){
    $days = @()

    if($table[$i].Days -ilike "M*"){  $days += "Monday"  }
    if($table[$i].Days -ilike "*T[*F]*"){  $days += "Tuesday"  }
    if($table[$i].Days -ilike "T"){  $days += "Tuesday"  }
    if($table[$i].Days -ilike "W"){  $days += "Wednesday"  }
    if($table[$i].Days -ilike "*TH"){  $days += "Thursday"  }
    if($table[$i].Days -ilike "F*"){  $days += "Friday"  }

$table[$i].Days = $days
}
return $table
}
