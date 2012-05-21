#!/bin/zsh


	# YOU SHOULD CHANGE THIS to reflect wherever you have nvALT set to store its 'Notes & Settings'
NVALT="$HOME/Dropbox/txt/Notes & Settings"

	# these are all the options we should try to use for $DIR
	# the first one which exists as a directory will be used
DIRS=(
	"$HOME/Dropbox/txt"
	"$HOME/Dropbox/"
	"$HOME/Desktop/"
	"$HOME/"
	"/tmp/"
)


	# Keyboard Maestro should set these two variables
FILENAME="${KMVAR_Title}"
TEXT="${KMVAR_Body}"

		# get the file extension, if any
	EXT="$KMVAR_Title:e"

NAME="$0:t"

GROWL_APP='nvALT'

	# These are all of the extensions that I have told nvALT to recognize
case "$EXT" in
	command|html|markdown|md|mmd|pl|plist|py|rb|rtf|sh|textastic|txt|xml|zsh)

			# These are all of the extensions that I want to be able to use
			# in nvALT. But, since these are not the default values for
			# nvALT, I want to check to make sure that the copy of nvALT
			# that I am using has been configured to use them. This check
			# is rudimentary and not fool-proof, but it's better than
			# nothing.

			# convert nvALT's preferences to XML
		plutil -convert xml1 "$NVALT"

			# look for the given extension as <string> in that file
		egrep -q "^		<string>$EXT</string>" "$NVALT" ||\
			msg sticky "nvALT may not be configured to recognize $EXT. Check preferences" >/dev/null

	;;

	*)
			# if there is no EXT or if the EXT doesn't match something in
			# the list above add .txt
		msg "Unknown EXT ($EXT), adding txt" >/dev/null
		FILENAME="$FILENAME.txt"

	;;

esac



####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

bail () {

	# we will only use this function if something goes wrong and we need to
	# exit prematurely (hence the name)

	ERROR="$@"

		# 'msg' is just a function I have which sends a message to 'growlnotify'
		# you can find it here if you want to use it too
		# https://www.dropbox.com/s/s75zdrcg46equdw/zf-msg.sh

	msg sticky "(ERROR = $ERROR) FAILED to save >$TEXT< to >$FILENAME< in >$DIR<."

		# IF the save does NOT work for whatever reason then open the
		# filename and text in default text editor as well as stdout
	echo "FILENAME: ${FILENAME} --- TEXT: ${TEXT}" | open -ef

	echo "FILENAME: ${FILENAME} --- TEXT: ${TEXT}"

	exit 1

}

####|####|####|####|####|####|####|####|####|####|####|####|####|####|####



if [[ "$FILENAME" == "" ]]
then

	# if TEXT is also empty, then there's nothing for us to do
	# so let's assume the user changed their mind
	[[ "$TEXT" == "" ]] && msg '$TEXT and $FILENAME are both empty' && exit 0

	# if filename is empty (but TEXT is not) then use current timestamp for filename
 	FILENAME=$(echo `timestamp`.txt)

fi



for DIR in $DIRS
do
	[[ -d "$DIR" ]] && break || DIR=''
done

[[ "$DIR" == "" ]] && bail '$DIR is empty'

SAVE_TO="$DIR/$FILENAME"

####|####|####|####|####|####|####|####|####|####|####|####|####|####|####

if [[ -e "$SAVE_TO" ]]
then
	# the file already exists, so we'll append to it, but we'll also add some spacing

	# IF the file already exists, append to it otherwise, create it
	echo "\n\n${TEXT}\n\n" >>| "${DIR}/${FILENAME}"

else # if we get here, the file we are trying to append to doesn't exist, so we create it

	# if the file doesn't exist, just send the text right to it.

	echo "${TEXT}" >>| "${DIR}/${FILENAME}"
fi

EXIT="$?"

if [ "$EXIT" = "0" ]
then

	# if the previous command was successful

	msg "SAVED: $TEXT to >${FILENAME}< in $DIR" >/dev/null

	if [[ "$KMVAR_Result_Button" = "Open" ]]
	then

		open "${DIR}/${FILENAME}"
	
	elif [[ "$KMVAR_Result_Button" = "Show" ]]
	then
	
		open "nvalt://find/$FILENAME:t:r"
	
	fi

	exit 0

else # IF we get here, something went wrong

	bail "Failed to save to $FILENAME"

fi



exit 0
# note: 'msg' can be found here: https://www.dropbox.com/s/s75zdrcg46equdw/zf-msg.sh
#EOF
