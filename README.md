# Gridcoin Delta Calculator is in the process of being rewritten from scratch. This version is not currently being updated. In the meantime you can use http://www.quickmag.ml instead



There is an [online version](http://quickmag.ml) with limited features


CPU_DeltaMag and GPU_DeltaMag are methods for determining the approximate performance of a given CPU/GPU on all Gridcoin whitelisted projects. These methods are a modified version of CPU_QuickMag.sh and GPU_QuickMag.sh that now use the Total
Credit Delta (TCD) method of determining the Magnitude and GRC/day for a specified CPU or GPU.

Requires: python 

# Steps for running code:

    bash UpdateCreditData.sh 
    
Wait at least 24 hours!
    
    bash UpdateCreditData.sh


    
    bash CPU_QuickMag.sh [CPUid] [#hosts] [output]
    
or  
    
    bash GPU_QuickMag.sh [GPUid] [#hosts] [output]

 
 
# Script details:

__________________________________________________________________________________________________________________
**bash UpdateCreditData.sh [debug]**
    
    [debug]		:	Can specify debug to enable progress bars
    
UpdateDatabaseFiles.sh downloads host and team data from the various BOINC projects on the Gridcoin whitlist
and saves the needed data to the local computer. It then uses database2delta.sh to calculate maginuted using the
TCD method.

__________________________________________________________________________________________________________________
**bash database2delta.sh [ProjectFileName]**
    
    [ProjectFileName]		:	Filename corresponding to desired project
    
database2delta.sh uses already downloaded host and team data to calculate which hosts have participated between
the current host database and the old host database. The magnitude for each host is calculated using TCD.

__________________________________________________________________________________________________________________


**bash CPU_DeltaMag.sh [CPUid] [#hosts] [output]**

    [CPUid]		:	CPU id string e.g. 'i7-6700 ' (check CPUlist.data for more examples)
    
    [#hosts]	: 	number of hosts to return data for
    
    [output]	:	save output to file name (optional)
    
CPU_QuickMag.sh reads the host data files to find the magnitude of the top [#hosts] hosts using the specified CPU model.
The data can be saved to a specified output file or printed to the terminal if [output] is not specified.
__________________________________________________________________________________________________________________

**CPUlist.data**

File contains the names of common CPU models formatted to work with CPU_QuickMag.sh
Note that spaces need to be preserved, for example 'i7-6700' will return a mix of 'i7-6700 ' and 'i7-6700K'

__________________________________________________________________________________________________________________


**bash GPU_DeltaMag.sh [GPUid] [#hosts] [output]**

    [GPUid]		:	GPU id string e.g. 'GTX 1080 Ti|1|' (check GPUlist.data for more examples)
    
    [#hosts]	: 	number of hosts to return data for
    
    [output]	:	save output to file name (optional)
    
GPU_QuickMag.sh reads the host data files to find the magnitude of the top [#hosts] hosts using a single card 
of the specified GPU model.
The data can be saved to a specified output file or printed to the terminal if [output] is not specified.
__________________________________________________________________________________________________________________

**GPUlist.data**

File contains the names of common GPU models formatted to work with GPU_QuickMag.sh
For example 'GTX 1080 Ti|1|' or 'RX 580 Series|1|'

Dual GPU cards need to be followed by a 2 (since BOINC detects each GPU die as a separate GPU).
e.g. 'TESLA K80|2|'. Due to the rarity of these cards, it is usually better to search for the single die version 
of the card and double the score.
__________________________________________________________________________________________________________________

**Project name abbreviations:**

	CPU Projects:

		odlk1 		Odlk1

		srbase 		Srbase

		yafu 		Yafu

		tngrid 		Tn-grid

		numf 		Numberfields@home
		
		nfs 		Nfs@home

		universe 	Universe@home

		csg 		Citizen Science Grid

		cosmology 	Cosmology@home

		lhc		Lhc@home Classic

		rosetta  	Rosetta@home

		yoyo 		Yoyo@home

		wcg		World Community Grid 
		
	
	GPU Projects:
		
		amicable 	Amicable Numbers
		
		collatz 	Collatz Conjecture
		
		einstein 	Einstein@home  	(No stats available - GDPR)
		
		milkyway 	Milkyway@home
		
		seti 		Seti@home
		
		gpug		GPUgrid
		
		asteroids 	Asteroids@home
