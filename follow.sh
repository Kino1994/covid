#!/bin/bash
for i in {1..100}
`sudo sleep 600`
do
  u=`sudo sed -n ${i}p followers.txt`
  `t follow "$u"`
  `sudo sleep 10`
done
a=`sudo wc followers.txt | cut -d ' ' -f 2 | sed -e "s/ //g"`
b=`sudo bc -l <<< $[a]-300`
`sudo head -n "$b" followers.txt >> followers2.txt`
`sudo rm followers.txt`
`sudo mv followers2.txt followers.txt`
