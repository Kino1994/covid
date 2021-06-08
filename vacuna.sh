1#!/bin/bash
`sudo sleep 120`
day=$(date +%d)
month=$(date +%m)
year=$(date +%y)
now=`echo 20$year$month$day`
`sudo wget -O /root/vacuna.pdf https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/documentos/Informe_GIV_comunicacion_$now.pdf`
`sudo pdftk /root/vacuna.pdf cat 2 output /root/vacuna2.pdf`
`sudo mv /root/vacuna2.pdf /root/vacuna.pdf`
`pdftotext -layout -nopgbrk /root/vacuna.pdf /root/vacuna.txt`
`sed -i -n '20,29p' /root/vacuna.txt`
`sed -i '/^[[:space:]]*$/d' /root/vacuna.txt`
`sed -i 's/\.//g' vacuna.txt`
`sed -n 1p /root/vacuna.txt | sed -e 's/ \{2,\}/ /g' | cut -d ")" -f 2  >> /root/vacuna2.txt`
`sed -n 2p /root/vacuna.txt | sed -e 's/ \{2,\}/ /g' | cut -d ")" -f 2 >> /root/vacuna2.txt`
`sed -n 4p /root/vacuna.txt | sed -e 's/ \{2,\}/ /g' | cut -d ")" -f 3 >> /root/vacuna2.txt`
`sed -n 6p /root/vacuna.txt | sed -e 's/ \{2,\}/ /g' | cut -d ")" -f 2 >> /root/vacuna2.txt`
janssen=`sed -n 4p /root/vacuna2.txt | cut -d " " -f 2  | paste -sd+ | bc`
least1=`cat /root/vacuna2.txt | cut -d " " -f 2  | paste -sd+ | bc`
complete=`cat /root/vacuna2.txt | cut -d " " -f 3 | paste -sd+ | bc`
partial=`sudo bc -l <<< $least1-$complete`
`sudo wget -O /root/vacuna.html https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm`
`sudo chmod 777 /root/vacuna.html`
`sudo grep "<p class=\"cifra\">*" /root/vacuna.html | cut -d ">" -f 2 | cut -d "<" -f 1 | cut -d ";" -f 2 | tail -n 3 | sed "s/\.//g" > /root/vacuna.txt`
`sudo chmod 777 /root/vacuna.txt`
aux1=`sudo head -n 1 /root/vacuna.txt`
aux2=`sudo sed -n '2p' /root/vacuna.txt`
aux3=`sudo tail -n 1 /root/vacuna.txt`
data1=`sudo numfmt --grouping $aux1`
data2=`sudo numfmt --grouping $aux2`
data3=`sudo numfmt --grouping $aux3`
data4=47344649 
none=`sudo bc -l <<< $data4-$least1`
template1="Dosis distribuidas:"
template2="Dosis administradas:"
template3="Dosis pendientes:"
template4="Tasa de administración:"
template5="Pauta completa:"
template6="Pauta incompleta:"
template7="Al menos una pauta:"
template8="Sin pauta:"
data=`sudo bc -l <<< $aux1-$aux2`
d1=`sudo numfmt --grouping $data`
d2=`sudo bc -l <<< $aux2/$aux1*100 | head -c 5 | sed -e 's/\./,/g'`
dataaux=$[$[aux2] - $[aux3]]
d3=`sudo numfmt --grouping $complete`
d4=`sudo numfmt --grouping $partial`
d5=`sudo numfmt --grouping $least1`
d6=`sudo numfmt --grouping $none`
d7=`sudo bc -l <<< $complete/$data4*100 | head -c 5 | sed -e 's/\./,/g'`
d8=`sudo bc -l <<< $partial/$data4*100 | head -c 5 | sed -e 's/\./,/g'`
d9=`sudo bc -l <<< $least1/$data4*100 | head -c 5 | sed -e 's/\./,/g'`
d10=`sudo bc -l <<< $none/$data4*100 | head -c 5 | sed -e 's/\./,/g'`
url="Fuente: Ministerio de Sanidad.\nhttps://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov/situacionActual.htm"
tweet="${template1} ${data1}\n${template2} ${data2}\n${template3} ${d1}\n${template4} ${d2}%\n${template5} ${d3} (${d7}%)\n${template6} ${d4} (${d8}%)\n${template7} ${d5} (${d9}%)\n${template8} ${d6} (${d10}%)"
`sudo echo -e "$tweet" > /root/vacuna.txt`
send=`sudo cat /root/vacuna.txt`
t update "$send"
`sudo rm /root/vacuna.html`
`sudo rm /root/vacuna.pdf`
`sudo rm /root/vacuna2.pdf`
`sudo rm /root/vacuna.txt`
`sudo rm /root/vacuna2.txt`
