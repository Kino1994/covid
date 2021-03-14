`wget -O vacuna.html https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm`
`grep "<p class=\"cifra\">*" vacuna.html | cut -d ">" -f 2 | cut -d "<" -f 1 | tail -n 3 | sed "s/\.//g" > vacuna.txt`
aux1=`head -n 1 vacuna.txt`
aux2=`sed -n '2p' vacuna.txt`
aux3=`tail -n 1 vacuna.txt`
data1=`numfmt --grouping $aux1`
data2=`numfmt --grouping $aux2`
data3=47351567
template1="Dosis distribuidas:"
template2="Dosis administradas:"
template3="Dosis pendientes:"
template4="Tasa de administracion:"
template5="Inmunizados parciales:"
template6="Inmunizados totales:"
template7="Tasa de inmunizacion:"
data=$[$[aux1] - $[aux2]]
d1=`numfmt --grouping $data`
d2=`bc -l <<< $aux2/$aux1*100 | head -c 5`
d3=`bc -l <<< $aux3/$data3*100 | head -c 5`
url="Fuente: Ministerio de Sanidad.\nhttps://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm"
tweet="${template1} ${data1}\n${template2} ${data2}\n${template3} ${d1}\n${template4} ${d2}%\n${template5} ${data2}\n${template6} ${data3}\n${template7} ${d3}%\n${url}"
`echo -e "$tweet" > vacuna.txt`
send=`cat vacuna.txt`
echo "$send"
rm vacuna.txt
rm vacuna.html
