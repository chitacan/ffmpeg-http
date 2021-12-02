#! /bin/sh

mkdir -p out

export ALLOW_ORIGIN="Access-Control-Allow-Origin: https://chitacan.static.observableusercontent.com\n"
shell2http -cgi -export-vars=ALLOW_ORIGIN -form -port 9991 \
  /run 'echo $ALLOW_ORIGIN; ffmpeg -y -i burger.mp4 -i touch.mp4 -filter_complex "${v_filter// /;}" -map "[out]" -c:v libx264 -x264opts "bframes=1:keyint=1:min-keyint=1:no-scenecut" out/$v_file; echo $v_file;' \
  /get 'echo $ALLOW_ORIGIN; cat out/${v_file//..//}' \
  /burger 'echo $ALLOW_ORIGIN; cat burger.mp4' \
  /touch 'echo $ALLOW_ORIGIN; cat touch.mp4' \
  /pptr 'echo $ALLOW_ORIGIN; cat pptr.mp4' \
  /exist 'if [ -e out/${v_file//..//} ]; then echo $ALLOW_ORIGIN; else echo "${ALLOW_ORIGIN}Status: 404\n\nNot Found\n"; fi'
