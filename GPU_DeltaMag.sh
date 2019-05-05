#! /bin/bash


## GPU_DeltaMag 
# 
# You must run $bash UpdateCreditData.sh multiple times before running this program to download the necessary data. 
# UpdateCreditData.sh needs to be run a second time (at least 24 hours later) to download a second snapshot of 
# host and team performance data. This necessary to allow this script to use the TCD method for determining earnings.
# 
#
# bash GPU_DeltaMag.sh [GPUid] [#hosts] [output]
# 
# [GPUid]	:	GPU id string e.g. 'GTX 1080 Ti|1|' (check GPUlist.data for more examples)
# [#hosts]	:	number of hosts to return data for
# [output]	:	save output to file name (optional)
#
# Requires: python
# 
# @author nexus-prime
# @version 2.0.1

# Check for help flag
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` 

# You must run $bash UpdateCreditData.sh multiple times before running this program to download the necessary data. 
# UpdateCreditData.sh needs to be run a second time (at least 24 hours later) to download a second snapshot of 
# host and team performance data. This necessary to allow this script to use the TCD method for determining earnings.
#
# bash GPU_DeltaMag.sh [GPUid] [#hosts] [output]
# 
# [GPUid]	:	GPU id string e.g. 'GTX 1080 Ti|1|' (check GPUlist.data for more examples)
# [#hosts]	:	number of hosts to return data for
# [output]	:	save output to file name (optional)
#
# Requires: python
 "
  exit 0
fi



# Check improper input
if [ $# -lt 2 ]; then
  echo 1>&2 "$0: not enough arguments, check --help"
  exit 2
elif [ $# -gt 3 ]; then
  echo 1>&2 "$0: too many arguments, check --help"
  exit 2
fi

# Rename Inputs
GPUid=$1
iters=$2
mypath="$( cd "$(dirname "$0")" ; pwd -P)"
# Print to terminal?
if [ $# -eq 2 ]; then
	StatsOut=$mypath/return.temp
else
	StatsOut=$3
fi
touch $StatsOut
#Get number of projects on current whitelist
NumWL=$(wget -q -O- https://www.gridcoinstats.eu/project/ | grep 'Included Projects:' | grep -Eo "[0-9]+")

#Declare projects and indexing
declare -a iterationSF=( "0 1 2 3 4 5 6" )
ProjWithStandForm=( amicable collatz enigma milkyway seti gpug asteroids )



## Get Top Rac for GPU model

nVidSearch=$( echo $GPUid | grep -iE "(GT|Quadro|NVS|TITAN|GeForce|Tesla|RTX)" )


if [ -n "$nVidSearch" ]; then
	
	amicable=$(cat $mypath/HostDeltaFiles/gAMICABLE | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}'| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	collatz=$(cat $mypath/HostDeltaFiles/gCOLLATZ | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	enigma=$(cat $mypath/HostDeltaFiles/gENIGMA | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	#einstein=$(cat $mypath/HostDeltaFiles/gEINSTEIN | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	milkyway=$(cat $mypath/HostDeltaFiles/gMW | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n  $iters) 
	seti=$(cat $mypath/HostDeltaFiles/gSETI | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	gpug=$(cat $mypath/HostDeltaFiles/gGPUG | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	asteroids=$(cat $mypath/HostDeltaFiles/gASTEROIDS 2>/dev/null | grep -i  "$GPUid" | sed -n '/CUDA*CUDA/!p;: m;//{$!{n;b m};}'| sed -n '/CAL/!p;: m;//{$!{n;b m};}' | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
else
	
	amicable=$(cat $mypath/HostDeltaFiles/gAMICABLE | grep -i  "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}' | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	collatz=$(cat $mypath/HostDeltaFiles/gCOLLATZ | grep -i  "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	enigma=$(cat $mypath/HostDeltaFiles/gENIGMA | grep -i  "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	#einstein=$(cat $mypath/HostDeltaFiles/gEINSTEIN | grep -i  "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	milkyway=$(cat $mypath/HostDeltaFiles/gMW | grep -i  "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n  $iters) 
	seti=$(cat $mypath/HostDeltaFiles/gSETI | grep -i  "$GPUid" | sed -n '/CAL*CAL/!p;: m;//{$!{n;b m};}'| sed -n '/CUDA/!p;: m;//{$!{n;b m};}'  | grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters) 
	eval gpug='$(for i in {1..'$iters'}; do echo -n '"'"'0 '"'"'; done)'
fi


#Check for missing data
for project in $iterationSF
do
	eval CurrentProj='${'${ProjWithStandForm[$project]}'[@]}'
	
	if [ -z "$CurrentProj" ]; then
		
		eval "${ProjWithStandForm[$project]}"='$(for i in {1..'$iters'}; do echo -n '"'"'0 '"'"'; done)'
		echo "Missing Host Data: ${ProjWithStandForm[$project]}"
	fi

done
unset CurrentProj
unset project

# Parse string to bash list
amicable=($amicable)   
collatz=($collatz)
enigma=($enigma)
#einstein=($einstein) 
milkyway=($milkyway)
seti=($seti)
gpug=($gpug)
asteroids=($asteroids)



# Insert table header
if [ -n "$nVidSearch" ]; then
	echo "Project  |  Top $iters magnitude(s) for Nvidia $GPUid" > $StatsOut
else
	echo "Project  |  Top $iters magnitude(s) for AMD $GPUid" > $StatsOut
fi


# Loop through projects
for project in $iterationSF
do
	#echo ${ProjWithStandForm[$project]}

	
	eval ProjData='${'${ProjWithStandForm[$project]}'[@]}'
	
	ProjData=(${ProjData[@]})
	
	locMag=''
		for jnd in `seq 0 $(($iters-1))`;
		do
			locMag[$jnd]="0.00"
			
			if [[ ${ProjData[$jnd]+abc} ]]; then
				locMag[$jnd]=$(python -c "print(${ProjData[$jnd]})") 		# Set local magnitude if host RAC data is present
			fi
			
		done

	printf "${ProjWithStandForm[$project]}" >> $StatsOut 							# Add project name to table
	LC_NUMERIC="en_US.UTF-8" printf " %0.2f" "${locMag[@]}" | sed 's/0.00/NULL/g' >> $StatsOut  			# Print host Mag with 2 decimals
	printf "\n"  >> $StatsOut 

	unset ProjData	
	unset locMag
done

# Print out table if no save location given
if [ $# -eq 2 ]; then
	head -n 1 $mypath/return.temp
	tail -n +2 $mypath/return.temp | column -t -s' ' 
	rm $mypath/return.temp
fi
