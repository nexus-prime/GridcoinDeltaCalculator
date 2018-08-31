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
 TotProj=23

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
(wget https://boinc.multi-pool.info/latinsquares/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cODLK1team.gz && gunzip -f  ./TeamFiles/cODLK1team.gz )&
sleep 5
(wget https://boinc.multi-pool.info/latinsquares/stats/host.gz -t 8 $PB -q -O ODLK1hosts.gz && gunzip -f  ODLK1hosts.gz && cat ODLK1hosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cODLK1hosts && rm ODLK1hosts ; echo " " >>fin.temp )&


(wget http://srbase.my-firewall.org/sr5/stats/host.gz -t 8 $PB -q -O SRBASEhosts.gz && gunzip -f  SRBASEhosts.gz && cat SRBASEhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cSRBASEhosts && rm SRBASEhosts ; echo " " >>fin.temp )&
(wget http://srbase.my-firewall.org/sr5/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cSRBASEteam.gz && gunzip -f  ./TeamFiles/cSRBASEteam.gz  )&

(wget http://yafu.myfirewall.org/yafu/stats/host.gz -t 8 $PB -q -O YAFUhosts.gz && gunzip -f  YAFUhosts.gz  && cat YAFUhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cYAFUhosts && rm YAFUhosts ; echo " " >>fin.temp )&
(wget http://yafu.myfirewall.org/yafu/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cYAFUteam.gz && gunzip -f  ./TeamFiles/cYAFUteam.gz )&

(wget http://gene.disi.unitn.it/test/stats/host.gz -t 8 $PB -q -O TNGRIDhosts.gz && gunzip -f  TNGRIDhosts.gz  && cat TNGRIDhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cTNGRIDhosts && rm TNGRIDhosts ; echo " " >>fin.temp )&
(wget http://gene.disi.unitn.it/test/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cTNGRIDteam.gz && gunzip -f  ./TeamFiles/cTNGRIDteam.gz  )&

(wget https://boinc.vgtu.lt/stats/host.gz  -t 8 $PB -q -O VGTUhosts.gz && gunzip -f  VGTUhosts.gz && cat VGTUhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cVGTUhosts && rm VGTUhosts ; echo " " >>fin.temp )&
(wget https://boinc.vgtu.lt/stats/team.gz  -t 8 $PB -q -O ./TeamFiles/cVGTUteam.gz && gunzip -f  ./TeamFiles/cVGTUteam.gz  )&

(wget https://escatter11.fullerton.edu/nfs/stats/host.gz -t 8 $PB -q -O NFShosts.gz && gunzip -f  NFShosts.gz  && cat NFShosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cNFShosts && rm NFShosts ; echo " " >>fin.temp )&
(wget https://escatter11.fullerton.edu/nfs/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cNFSteam.gz && gunzip -f  ./TeamFiles/cNFSteam.gz  )&

(wget https://numberfields.asu.edu/NumberFields/stats/host.gz -t 8 $PB -q -O NUMFhosts.gz && gunzip -f  NUMFhosts.gz  && cat NUMFhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cNUMFhosts && rm NUMFhosts ; echo " " >>fin.temp )&
(wget https://numberfields.asu.edu/NumberFields/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cNUMFteam.gz && gunzip -f  ./TeamFiles/cNUMFteam.gz  )&

(wget https://universeathome.pl/universe/stats/host.gz -t 8 $PB -q -O UNIVERSEhosts.gz && gunzip -f  UNIVERSEhosts.gz  && cat UNIVERSEhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cUNIVERSEhosts && rm UNIVERSEhosts ; echo " " >>fin.temp )&
(wget https://universeathome.pl/universe/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cUNIVERSEteam.gz && gunzip -f  ./TeamFiles/cUNIVERSEteam.gz  )&

(wget https://csgrid.org/csg/stats/host.gz -t 8 $PB -q -O CSGhosts.gz && gunzip -f  CSGhosts.gz  && cat CSGhosts| grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cCSGhosts && rm CSGhosts ; echo " " >>fin.temp )&
(wget https://csgrid.org/csg/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cCSGteam.gz && gunzip -f  ./TeamFiles/cCSGteam.gz  )&

(wget https://cosmologyathome.org/stats/host.gz -t 8 $PB -q -O COSMOLOGYhosts.gz && gunzip -f  COSMOLOGYhosts.gz   && cat COSMOLOGYhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cCOSMOLOGYhosts && rm COSMOLOGYhosts ; echo " " >>fin.temp )&
(wget https://cosmologyathome.org/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cCOSMOLOGYteam.gz && gunzip -f  ./TeamFiles/cCOSMOLOGYteam.gz )&

(wget https://lhcathome.cern.ch/lhcathome/stats/host.gz -t 8 $PB -q -O LHChosts.gz && gunzip -f  LHChosts.gz  && cat LHChosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cLHChosts && rm LHChosts ; echo " " >>fin.temp )&
(wget https://lhcathome.cern.ch/lhcathome/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cLHCteam.gz && gunzip -f  ./TeamFiles/cLHCteam.gz  )&

(wget http://boinc.bakerlab.org/rosetta/stats/host.gz -t 8 $PB -q -O ROSETTAhosts.gz && gunzip -f  ROSETTAhosts.gz && cat ROSETTAhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cROSETTAhosts && rm ROSETTAhosts ; echo " " >>fin.temp )&
(wget http://boinc.bakerlab.org/rosetta/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cROSETTAteam.gz && gunzip -f  ./TeamFiles/cROSETTAteam.gz  )&

(wget http://www.rechenkraft.net/yoyo/stats/host.gz -t 8 $PB -q -O YOYOhosts.gz && gunzip -f  YOYOhosts.gz && cat YOYOhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cYOYOhosts && rm YOYOhosts ; echo " " >>fin.temp )&
(wget http://www.rechenkraft.net/yoyo/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cYOYOteam.gz && gunzip -f  ./TeamFiles/cYOYOteam.gz )&


(wget https://download.worldcommunitygrid.org/boinc/stats/host.gz -t 8 $PB -q -O WCGhosts.gz && gunzip -f WCGhosts.gz && cat WCGhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/cWCGhosts && rm WCGhosts ; echo " " >>fin.temp )&
(wget https://download.worldcommunitygrid.org/boinc/stats/team.gz -t 8 $PB -q -O ./TeamFiles/cWCGteam.gz && gunzip -f ./TeamFiles/cWCGteam.gz  )&




# Download New GPU Files

(wget https://sech.me/boinc/Amicable/stats/host.gz -t 8 $PB -q -O AMICABLEhosts.gz && gunzip -f  AMICABLEhosts.gz && cat AMICABLEhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gAMICABLEhosts && rm AMICABLEhosts ; echo " " >>fin.temp )&
(wget https://sech.me/boinc/Amicable/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gAMICABLEteam.gz && gunzip -f  ./TeamFiles/gAMICABLEteam.gz  )&

(wget http://boinc.thesonntags.com/collatz/stats/host.gz -t 8 $PB -q -O COLLATZhosts.gz && gunzip -f  COLLATZhosts.gz   && cat COLLATZhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gCOLLATZhosts && rm COLLATZhosts ; echo " " >>fin.temp )&
(wget http://boinc.thesonntags.com/collatz/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gCOLLATZteam.gz && gunzip -f  ./TeamFiles/gCOLLATZteam.gz )& 

(wget https://einsteinathome.org/stats/host_id.gz -t 8 $PB -q -O EINSTEINhosts.gz && gunzip -f  EINSTEINhosts.gz   && cat EINSTEINhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gEINSTEINhosts && rm EINSTEINhosts ; echo " " >>fin.temp )&
(wget https://einsteinathome.org/stats/team_id.gz -t 8 $PB -q -O ./TeamFiles/gEINSTEINteam.gz && gunzip -f  ./TeamFiles/gEINSTEINteam.gz  )&

(wget http://www.enigmaathome.net/stats/host.gz -t 8 $PB -q -O ENIGMAhosts.gz && gunzip -f  ENIGMAhosts.gz  && cat ENIGMAhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gENIGMAhosts && rm ENIGMAhosts ; echo " " >>fin.temp )&
(wget http://www.enigmaathome.net/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gENIGMAteam.gz && gunzip -f  ./TeamFiles/gENIGMAteam.gz  )&

(wget https://www.gpugrid.net/stats/host.gz -t 8 $PB -q -O GPUGhosts.gz && gunzip -f  GPUGhosts.gz && cat GPUGhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gGPUGhosts && rm GPUGhosts ; echo " " >>fin.temp )&
(wget https://www.gpugrid.net/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gGPUGteam.gz && gunzip -f  ./TeamFiles/gGPUGteam.gz  )&

(wget http://milkyway.cs.rpi.edu/milkyway/stats/host.gz -t 8 $PB -q -O MWhosts.gz && gunzip -f  MWhosts.gz  && cat MWhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gMWhosts && rm MWhosts ; echo " " >>fin.temp )&
(wget http://milkyway.cs.rpi.edu/milkyway/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gMWteam.gz && gunzip -f  ./TeamFiles/gMWteam.gz  )&

(wget http://23.253.170.196/stats/host.gz -t 8 $PB -q -O PGRIDhosts.gz && gunzip -f  PGRIDhosts.gz  && cat PGRIDhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gPGRIDhosts && rm PGRIDhosts ; echo " " >>fin.temp )&
(wget http://23.253.170.196/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gPGRIDteam.gz && gunzip -f  ./TeamFiles/gPGRIDteam.gz )& 

(wget http://setiathome.ssl.berkeley.edu/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gSETIteam.gz && gunzip -f  ./TeamFiles/gSETIteam.gz  ) &
sleep 10
(wget http://setiathome.ssl.berkeley.edu/stats/host.gz -t 8 $PB -q -O SETIhosts.gz  && gunzip -f  SETIhosts.gz && cat SETIhosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gSETIhosts && rm SETIhosts ; echo " " >>fin.temp )&

(wget http://asteroidsathome.net/boinc/stats/host.gz -t 8 $PB -q -O ASTEROIDShosts.gz && gunzip -f  ASTEROIDShosts.gz   && cat ASTEROIDShosts | grep -E "(host|coprocs|p_model|expavg_credit|total_credit|<id>)"> ./HostFiles/gASTEROIDShosts && rm ASTEROIDShosts ; echo " " >>fin.temp )&
(wget http://asteroidsathome.net/boinc/stats/team.gz -t 8 $PB -q -O ./TeamFiles/gASTEROIDSteam.gz && gunzip -f  ./TeamFiles/gASTEROIDSteam.gz )& 




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
(bash database2delta.sh gAMICABLE) 
echo "gCOLLATZ"
(bash database2delta.sh gCOLLATZ) 
#(bash database2delta.sh gEINSTEIN)& 
echo "gENIGMA"
(bash database2delta.sh gENIGMA) 
echo "gGPUG"
(bash database2delta.sh gGPUG) 
echo "gMW"
(bash database2delta.sh gMW) 
echo "gPGRID"
(bash database2delta.sh gPGRID) 
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

