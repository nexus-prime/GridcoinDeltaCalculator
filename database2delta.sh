#! /bin/bash


# Check for help flag
if [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
  echo "Usage: `basename $0` 

# You must run 'bash UpdateCreditData.sh' twice at least 24 hours appart before running 
# this program to download the necessary data. 
#
# bash GridcoinDeltaCalculator.sh [ProjectFileName]
# 
# [ProjectFileName]		:	Filename corresponding to desired project
#
# Requires: python
 "
  exit 0
fi


# Rename Inputs
projectname=$1
databaseFileName=$projectname'hosts'
teamFileName=$projectname'team'
mypath="$( cd "$(dirname "$0")" ; pwd -P)"




rm -f $mypath/HostDeltaFiles/$databaseFileName
OldDatabase=$mypath/HostFiles.old/$databaseFileName
NewDatabase=$mypath/HostFiles/$databaseFileName
NumWL=$(wget -q -O- https://www.gridcoinstats.eu/project/ | grep 'Included Projects:' | grep -Eo "[0-9]+")

TeamCreditNew=$(cat $mypath/TeamFiles/$teamFileName | grep -i -A 4 'name>gridcoin</name' | grep '<total_credit>' | sed -e 's/<[^>]*>//g')
TeamCreditOld=$(cat $mypath/TeamFiles.old/$teamFileName | grep -i -A 4 'name>gridcoin</name' | grep '<total_credit>' | sed -e 's/<[^>]*>//g')
#echo $TeamCreditNew
#echo $TeamCreditOld

DeltaCreditTeamMult=$(python -c "print ($TeamCreditNew-$TeamCreditOld)/(115000/$NumWL)")
#echo $DeltaCreditTeamMult
# Process New Database
cat $NewDatabase | grep -v 'host_cpid' | tr '\n' ' ' | sed 's%<\/host> <host>%~%g' | tr '~' "\n" > $mypath/new.data.$projectname
sort -o $mypath/new.data.$projectname $mypath/new.data.$projectname

cat $mypath/new.data.$projectname | grep -o '<id>.*</id>' > $mypath/new.id.temp.$projectname
cat $mypath/new.data.$projectname | grep -o '<total_credit>.*' > $mypath/new.data.temp.$projectname

# Process Old Database
cat $OldDatabase | grep -v 'host_cpid' | tr '\n' ' ' | sed 's%<\/host> <host>%~%g' | tr '~' "\n" > $mypath/old.data.$projectname
sort -o $mypath/old.data.$projectname $mypath/old.data.$projectname

cat $mypath/old.data.$projectname | grep -o '<id>.*</id>' > $mypath/old.id.temp.$projectname
cat $mypath/old.data.$projectname | grep -o '<total_credit>.*' > $mypath/old.data.temp.$projectname

# Find consistent lines in new.data
comm -1 $mypath/old.id.temp.$projectname $mypath/new.id.temp.$projectname | sed 's/\t/~/g' > $mypath/newKeyedID.temp.$projectname
comm -2 $mypath/old.id.temp.$projectname $mypath/new.id.temp.$projectname | sed 's/\t/~/g' > $mypath/oldKeyedID.temp.$projectname


# Reassemble data tables
paste $mypath/newKeyedID.temp.$projectname $mypath/new.data.temp.$projectname | grep '~' > $mypath/new.data.$projectname
paste $mypath/oldKeyedID.temp.$projectname $mypath/old.data.temp.$projectname | grep '~' > $mypath/old.data.$projectname
rm $mypath/new.id.temp.$projectname
rm $mypath/new.data.temp.$projectname
rm $mypath/old.id.temp.$projectname
rm $mypath/old.data.temp.$projectname
rm $mypath/oldKeyedID.temp.$projectname
rm $mypath/newKeyedID.temp.$projectname

cat $mypath/new.data.$projectname | grep -o '<total_credit>.*</total_credit>' | sed -e 's/<[^>]*>//g' > $mypath/new.credit.temp.$projectname
cat $mypath/old.data.$projectname | grep -o '<total_credit>.*</total_credit>' | sed -e 's/<[^>]*>//g' > $mypath/old.credit.temp.$projectname

paste -d' ' $mypath/new.credit.temp.$projectname $mypath/old.credit.temp.$projectname | awk '{ printf("%f\n", $1-$2); }' | awk -v c=$DeltaCreditTeamMult '{ print $1/c }'|sed -e 's/^/<delta_MAG>/g' | sed -e 's%$%</delta_MAG>%g' > $mypath/delta.credit.temp.$projectname
rm $mypath/new.credit.temp.$projectname
rm $mypath/old.credit.temp.$projectname

# add delta credit to tables
paste $mypath/new.data.$projectname $mypath/delta.credit.temp.$projectname | grep -v '<delta_MAG>0</delta_MAG>' > $mypath/HostDeltaFiles/$projectname

rm $mypath/delta.credit.temp.$projectname
rm $mypath/new.data.$projectname
rm $mypath/old.data.$projectname



# date +%s > SavedTime.txt

