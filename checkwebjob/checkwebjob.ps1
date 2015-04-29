Clear-Host

$url_list=Content G:\github\checkwebjob\checkwebjob\efeList.txt

Get-Job |Remove-Job -Force


$htmlgraficas="G:\github\checkwebjob\checkwebjob\htmlgraficas.html"
"<HTML><TITLE>TIEMPOS WEBS EFE</TITLE><BODY><H2> WEBS EFE</H2><Table>" >> $htmlgraficas
"">>$htmlgraficas


foreach ($url in $url_list){

$nombre_tarea="$url"
Start-Job -FilePath "G:\github\checkwebjob\checkwebjob\scriptjob.ps1"  -Name $nombre_tarea -ArgumentList $url


$directorio="G:\github\checkwebjob\checkwebjob\"+$url+".png"
"">directorio

"<TR> <TD> <IMG SRC=$directorio> </TD></TR>" >>$htmlgraficas
}



while ($(Get-Job -State Running).count -gt 0){

#$(Get-Job -state Running).count

Write-Progress -Activity "checkwebjob" -PercentComplete (($(Get-Job -state Running).count) /$url_list.Count * 100)
Start-Sleep 3

}

"</Table></BODY></HTML>" >> $htmlgraficas

Get-Job |Remove-Job -Force