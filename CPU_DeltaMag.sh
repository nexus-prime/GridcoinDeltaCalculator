#! /bin/bash


## CPU_QuickMag 
# 
# You must run $bash UpdateCreditData.sh multiple times before running this program to download the necessary data. 
# UpdateCreditData.sh needs to be run a second time (at least 24 hours later) to download a second snapshot of 
# host and team performance data. This necessary to allow this script to use the TCD method for determining earnings.
# 
#
# bash CPU_DeltaMag.sh [CPUid] [#hosts] [output]
# 
# [CPUid]	:	CPU id string e.g. 'i7-6700 ' (check CPUlist.data for more examples)
# [#hosts]	:	number of hosts to return data for
# [output]	:	save output to file name (optional)
#
# Requires: python and math package
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
# bash CPU_DeltaMag.sh [CPUid] [#hosts] [output]
# 
# [CPUid]	:	CPU id string e.g. 'i7-6700 ' (check CPUlist.data for more examples)
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
CPUid=$1
iters=$2

mypath="$( cd "$(dirname "$0")" ; pwd -P)"

# Print to terminal?
if [ $# -eq 2 ]; then
	StatsOut=$mypath/return.temp
else
	StatsOut=$3
fi
touch $StatsOut


#Declare projects and indexing
declare -a iterationSF=( "0 1 2 3 4 5 6 7 8 9 10 11 12" ) #( "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17" )
#ProjWithStandForm=( odlk1 srbase yafu tngrid vgtu DD numf nfs pogs universe csg cosmology lhc asteroids rosetta  yoyo wcg dhep)
ProjWithStandForm=( odlk1 srbase yafu tngrid numf nfs universe cosmology lhc rosetta  yoyo wcg dhep)

## Get Top Rac for CPU model
odlk1=$(cat $mypath/HostDeltaFiles/cODLK1 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
srbase=$(cat $mypath/HostDeltaFiles/cSRBASE 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
yafu=$(cat $mypath/HostDeltaFiles/cYAFU 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
tngrid=$(cat $mypath/HostDeltaFiles/cTNGRID 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
#vgtu=$(cat $mypath/HostDeltaFiles/cVGTU 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
numf=$(cat $mypath/HostDeltaFiles/cNUMF 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
nfs=$(cat $mypath/HostDeltaFiles/cNFS 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
universe=$(cat $mypath/HostDeltaFiles/cUNIVERSE 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
#csg=$(cat $mypath/HostDeltaFiles/cCSG 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
cosmology=$(cat $mypath/HostDeltaFiles/cCOSMOLOGY 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
lhc=$(cat $mypath/HostDeltaFiles/cLHC 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
rosetta=$(cat $mypath/HostDeltaFiles/cROSETTA 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
yoyo=$(cat $mypath/HostDeltaFiles/cYOYO 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters ) 
wcg=$(cat $mypath/HostDeltaFiles/cWCG 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters )   # Temporary Issues with GDPR compliance
dhep=$(cat $mypath/HostDeltaFiles/cDHEP 2>/dev/null | grep -i "$CPUid"| grep -o '<delta_MAG>.*</delta_MAG>'|grep -Eo "[0-9]+\.[0-9]+"| sort -rn | head -n $iters )

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
odlk1=($odlk1)
srbase=($srbase)
yafu=($yafu)
tngrid=($tngrid)
#vgtu=($vgtu)
numf=($numf)
nfs=($nfs)
pogs=($pogs)
universe=($universe)
#csg=($csg)
cosmology=($cosmology)
lhc=($lhc)
rosetta=($rosetta)
yoyo=($yoyo)
wcg=($wcg) 
dhep=($dhep) 




# Insert table header
echo "Project  |  Top $iters magnitude(s) for $CPUid" > $StatsOut



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
