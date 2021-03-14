
`sudo wget -O /home/joaquin/vacuna.html https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm`
`sudo grep "<p class=\"cifra\">*" /home/joaquin/vacuna.html | cut -d ">" -f 2 | cut -d "<" -f 1 | tail -n 3 | sed "s/\.//g" > /home/joaquin/vacuna.txt`
aux1=`sudo head -n 1 /home/joaquin/vacuna.txt`
aux2=`sudo sed -n '2p' /home/joaquin/vacuna.txt`
aux3=`sudo tail -n 1 /home/joaquin/vacuna.txt`
data1=`sudo numfmt --grouping $aux1`
data2=`sudo numfmt --grouping $aux2`
data3=`sudo numfmt --grouping $aux3`
data4=47351567
template1="Dosis distribuidas:"
template2="Dosis administradas:"
template3="Dosis pendientes:"
template4="Tasa de administracion:"
template5="Parcialmente inmunizados:"
template6="Totalmente inmunizados:"
template7="Tasa de inmunizacion parcial:"
template8="Tasa de inmunizacion completa:"
data=`sudo bc -l <<< $aux1-$aux2`
d1=`sudo numfmt --grouping $data`
d2=`sudo bc -l <<< $aux2/$aux1*100 | head -c 5`
dataaux=$[$[aux2] - $[aux3]]
d3=`sudo numfmt --grouping $dataaux`
d4=`sudo bc -l <<< $dataaux/$data4*100 | head -c 5`
d5=`sudo bc -l <<< $aux3/$data4*100 | head -c 5`
url="Fuente: Ministerio de Sanidad.\nhttps://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm"
tweet="${template1} ${data1}\n${template2} ${data2}\n${template3} ${d1}\n${template4} ${d2}%\n${template5} ${d3}\n${template6} ${data3}\n${template7} ${d4}%\n${template8} ${d5}%"
`sudo echo -e "$tweet" > /home/joaquin/vacuna.txt`
send=`sudo cat /home/joaquin/vacuna.txt`
t update "$send"
`sudo rm /home/joaquin/vacuna.txt`
`sudo rm /home/joaquin/vacuna.html`
