#!/bin/bash
`sudo sleep 600`
for i in {1..100}
do
  u=`sudo sed -n ${i}p followers.txt`
  t follow "$u"
  `sudo sleep 10`
done
a=`sudo wc followers.txt | cut -d ' ' -f 2 | sed -e "s/ //g"`
b=`sudo bc -l <<< $[a]-300`
`sudo head -n "$b" /root/followers.txt >> /root/followers2.txt`
`sudo rm /root/followers.txt`
`sudo mv /root/followers2.txt /root/followers.txt`
