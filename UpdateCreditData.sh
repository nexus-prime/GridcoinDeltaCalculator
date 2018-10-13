#! /bin/bash
 
 # Download host and team data from BOINC projects on the Gridcoin whitelist (and greylist)
#
# bash UpdateCreditData.sh [debug]
#
# [debug]			:	Can specify debug to enable progress bars
#
# @author nexus-prime
# @version 2.0
 
# Respond to help flag
 if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` 

# Download host and team data from BOINC projects on the Gridcoin whitelist (and greylist)
#
# bash UpdateCreditData.sh [Project Type] [debug]
# 
#
# [debug]			:	Can specify debug to enable progress bars
#
# @author nexusgroup
# @version 1.4
 "
  exit 0
fi

set -o pipefail
 
 # Handle bad inputs
 if [ $# -lt 1 ]; then
	PB=''
 else
	 if [ $1 == "-debug" ] || [ $1 == "debug" ] || [ $1 == "-v" ]; then
		PB='--show-progress'
	 else
		PB=''
	 fi
  fi
 TotProj=24

  # Use ripgrep if it is on the system
 if which rg 2>&1 > /dev/null ; then
   grepcmd=rg
   grepcmde=rg
 else
   grepcmd=grep
   grepcmde="grep -E"
 fi
 
# Setup for downloading
rm -f fin.temp
touch fin.temp

echo "Starting $TotProj downloads..."
echo ' '

if [ -z "$PB" ];then
	printf "\rProgress: 0%%"
fi
# Download CPU projects


# Clear Old Files 

rm -rf ./HostFiles.old/
mv ./HostFiles/ ./HostFiles.old/ 2>/dev/null
rm -rf ./TeamFiles.old/
mv ./TeamFiles/ ./TeamFiles.old/ 2>/dev/null
rm -rf ./HostDeltaFiles/

 mkdir -p TeamFiles
 mkdir -p HostFiles
 mkdir -p HostDeltaFiles

date +%s > ./HostFiles/SavedTime.txt
# Download New CPU Files
(wget https://boinc.multi-pool.info/latinsquares/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/cODLK1team ) &
wait #ODLK doesn't like simultaneous downloads
sleep 1
(wget https://boinc.multi-pool.info/latinsquares/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cODLK1hosts ; echo " " >>fin.temp )&


(wget http://srbase.my-firewall.org/sr5/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cSRBASEhosts ; echo " " >>fin.temp )&
(wget http://srbase.my-firewall.org/sr5/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/cSRBASEteam  ) &

(wget http://yafu.myfirewall.org/yafu/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cYAFUhosts ; echo " " >>fin.temp )&
(wget http://yafu.myfirewall.org/yafu/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cYAFUteam )&

(wget http://gene.disi.unitn.it/test/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cTNGRIDhosts ; echo " " >>fin.temp )&
(wget http://gene.disi.unitn.it/test/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cTNGRIDteam  )&

(wget https://boinc.vgtu.lt/stats/host.gz  -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cVGTUhosts ; echo " " >>fin.temp )&
(wget https://boinc.vgtu.lt/stats/team.gz  -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cVGTUteam  )&

(wget https://escatter11.fullerton.edu/nfs/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cNFShosts ; echo " " >>fin.temp )&
(wget https://escatter11.fullerton.edu/nfs/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cNFSteam  )&

(wget https://numberfields.asu.edu/NumberFields/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cNUMFhosts ; echo " " >>fin.temp )&
(wget https://numberfields.asu.edu/NumberFields/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cNUMFteam  )&

(wget https://universeathome.pl/universe/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cUNIVERSEhosts ; echo " " >>fin.temp )&
(wget https://universeathome.pl/universe/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cUNIVERSEteam  )&

(wget https://csgrid.org/csg/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cCSGhosts ; echo " " >>fin.temp )&
(wget https://csgrid.org/csg/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cCSGteam  )&

(wget https://cosmologyathome.org/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cCOSMOLOGYhosts ; echo " " >>fin.temp )&
(wget https://cosmologyathome.org/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cCOSMOLOGYteam )&

(wget https://lhcathome.cern.ch/lhcathome/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cLHChosts ; echo " " >>fin.temp )&
(wget https://lhcathome.cern.ch/lhcathome/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cLHCteam  )&

(wget http://boinc.bakerlab.org/rosetta/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cROSETTAhosts ; echo " " >>fin.temp )&
(wget http://boinc.bakerlab.org/rosetta/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cROSETTAteam  )&

(wget http://www.rechenkraft.net/yoyo/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cYOYOhosts ; echo " " >>fin.temp )&
(wget http://www.rechenkraft.net/yoyo/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/cYOYOteam )&


(wget https://download.worldcommunitygrid.org/boinc/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cWCGhosts ; echo " " >>fin.temp )&
(wget https://download.worldcommunitygrid.org/boinc/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/cWCGteam  )&

(wget https://www.dhep.ga/boinc/stats/host.gz -t 4 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)" > ./HostFiles/cDHEPhosts ; echo " " >>fin.temp ) &
(wget https://www.dhep.ga/boinc/stats/team.gz -t 4 $PB -q -O - -o /dev/null | gunzip > ./TeamFiles/cDHEPteam ) &

# Download New GPU Files

(wget https://sech.me/boinc/Amicable/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gAMICABLEhosts ; echo " " >>fin.temp )&
(wget https://sech.me/boinc/Amicable/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gAMICABLEteam  )&

(wget http://boinc.thesonntags.com/collatz/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gCOLLATZhosts ; echo " " >>fin.temp )&
(wget http://boinc.thesonntags.com/collatz/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gCOLLATZteam )& 

(wget https://einsteinathome.org/stats/host_id.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gEINSTEINhosts ; echo " " >>fin.temp )&
(wget https://einsteinathome.org/stats/team_id.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gEINSTEINteam  )&

(wget http://www.enigmaathome.net/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gENIGMAhosts ; echo " " >>fin.temp )&
(wget http://www.enigmaathome.net/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gENIGMAteam  )&

(wget https://www.gpugrid.net/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gGPUGhosts ; echo " " >>fin.temp )&
(wget https://www.gpugrid.net/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gGPUGteam  )&

(wget http://milkyway.cs.rpi.edu/milkyway/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gMWhosts ; echo " " >>fin.temp )&
(wget http://milkyway.cs.rpi.edu/milkyway/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gMWteam  )&

(wget http://23.253.170.196/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gPGRIDhosts ; echo " " >>fin.temp )&
(wget http://23.253.170.196/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gPGRIDteam )& 

(wget http://setiathome.ssl.berkeley.edu/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gSETIteam  ) &
sleep 10
(wget http://setiathome.ssl.berkeley.edu/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gSETIhosts ; echo " " >>fin.temp )&

(wget http://asteroidsathome.net/boinc/stats/host.gz -t 8 $PB -q -O - -o /dev/null | gunzip | $grepcmde "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gASTEROIDShosts ; echo " " >>fin.temp )&
(wget http://asteroidsathome.net/boinc/stats/team.gz -t 8 $PB -q -O - -o /dev/null | gunzip >  ./TeamFiles/gASTEROIDSteam )& 




# Wait for download and decompress to finish
count=0

if [ -z "$PB" ];then

 while [  $count -lt $TotProj ]; do
	count=$(wc -l < fin.temp)

	 percent=$( awk "BEGIN { pc=100*${count}/${TotProj}; i=int(pc); print (pc-i<0.5)?i:i+1 }" )

	 printf "\rProgress: $percent%%"	
	 
	 sleep 1
	
 done
 
 fi
 
 
 
 wait
echo " "

echo "All Downloads Complete"
echo ""
echo "Checking for old host and team data..."

if [ -d "./HostFiles.old/" ] && [ -d "./TeamFiles.old/" ]; then
echo "Old data directory located, proceeding with TCD calculations..."

 # Mag Calculations
 echo "gSETI"
(bash database2delta.sh gSETI)&
 echo "gAMICABLE"
(bash database2delta.sh gAMICABLE) &
echo "gCOLLATZ"
(bash database2delta.sh gCOLLATZ) 
#(bash database2delta.sh gEINSTEIN)
echo "gENIGMA"
(bash database2delta.sh gENIGMA) 
echo "gGPUG"
(bash database2delta.sh gGPUG) 
echo "gMW"
(bash database2delta.sh gMW) 
#echo "gPGRID"
#(bash database2delta.sh gPGRID) 
echo "gASTEROIDS"
bash database2delta.sh gASTEROIDS
 
echo "cNFS"
(bash database2delta.sh cNFS)& 
 echo "cODLK1"
(bash database2delta.sh cODLK1) 
echo "cSRBASE"
(bash database2delta.sh cSRBASE) 
echo "cYAFU"
(bash database2delta.sh cYAFU) 
echo "cTNGRID"
(bash database2delta.sh cTNGRID) 
echo "cVGTU"
(bash database2delta.sh cVGTU) 
echo "cNUMF"
(bash database2delta.sh cNUMF) 
echo "cUNIVERSE"
(bash database2delta.sh cUNIVERSE) 
echo "cCSG"
(bash database2delta.sh cCSG) 
echo "cCOSMOLOGY"
(bash database2delta.sh cCOSMOLOGY) 
echo "cLHC"
(bash database2delta.sh cLHC) 
echo "cROSETTA"
(bash database2delta.sh cROSETTA) 
echo "cYOYO"
(bash database2delta.sh cYOYO) 
echo "cWCG"
(bash database2delta.sh cWCG) 
echo "cWCG"
(bash database2delta.sh cDHEP) 

else
	echo "Old files missing! Cannot proceed with TCD calculations"
	echo "Run this script again at least 24 hours from now."

 fi
 
 wait
 
 # Clean Up
rm fin.temp
rm -f *.gz
rm -f ./HostFiles/*.gz
rm -f ./TeamFiles/*.gz

