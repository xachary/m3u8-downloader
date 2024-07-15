#!/bin/bash

IFS=$'\n'

echo "input url:"
read arr

urls=$(echo $arr | tr "|" "\n")

total=$(echo $arr | tr "|" "\n" | wc -w)
count=1

for url in $urls
do
    echo
    echo "【任务 $count/$total】"
    count=$(($count + 1))

    node /home/m3u8/index.js "$url" /home/video/51

    file=/home/video/51/$(echo $url | sed 's/.*title=\([^&]*\).*/\1/')

    #echo "$file.mp4"

    #echo "$(echo $file)_ok.mp4"

    if [ -f "$file.mp4" ]; then 
        echo "【转码中】"
        ffmpeg -i "$file.mp4" -c copy -y -v quiet "$(echo $file)_ok.mp4"
        rm -f "$file.mp4" || true
        echo "【转码完成】"
    fi
done

echo
echo 【任务结束】
echo