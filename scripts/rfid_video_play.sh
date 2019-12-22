#!/bin/bash
File=$1

# Set the date and time of now
NOW=`date +%Y-%m-%d.%H:%M:%S`

# The absolute path to the folder which contains all the scripts.
# Unless you are working with symlinks, leave the following line untouched.
PATHDATA="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#############################################################
# $DEBUG TRUE|FALSE
# Read debug logging configuration file
. $PATHDATA/../settings/debugLogging.conf

if [ "${DEBUG_rfid_video_play_sh}" == "TRUE" ]; then echo "########### SCRIPT rfid_video_play.sh ($NOW) ##" >> $PATHDATA/../logs/debug.log; fi

	#check if player is already playing, stop if running
	if $PATHDATA/dbuscontrol.sh status ; 
		then 
		        if [ "${DEBUG_rfid_video_play_sh}" == "TRUE" ]; then echo "Closing video player" >> $PATHDATA/../logs/debug.log; fi
	    	        $PATHDATA/dbuscontrol.sh stop #closes the omxplayer, can also be changed to 'pause'
			firstTime=false
			exit
		else 
			echo "start video player" 
			firstTime=true
	fi
	if [ "${DEBUG_rfid_video_play_sh}" == "TRUE" ]; then echo "Attempting to play video-folder: '${File}'" >> $PATHDATA/../logs/debug.log; fi

	videoFile=$(ls ${File}/*.mp4 | head -1)
	if [ "${DEBUG_rfid_video_play_sh}" == "TRUE" ]; then echo "Attempting to play video-file: '${videoFile}'" >> $PATHDATA/../logs/debug.log; fi

	#open omxplayer -b for black background -z for ignoring refresh rate
	omxplayer -o both -b -z "$videoFile" &
	sleep 1 #sleep commands helps us from spawning too many processes
exit
