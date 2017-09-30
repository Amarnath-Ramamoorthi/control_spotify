#!/bin/sh
#
# Title: Control Spotify using shell commands
# Description:
#   Control Spotify using this bash script
#   Commands are simple play / pause, next, prev, title, artist, album, status
# [1] Addded volume up / down actullay this is to control machine volume not spotify actually 
# [2] play is used to control both play and pause
# 
# developed by AR
# Refrenced from 
# https://community.spotify.com/t5/Desktop-Linux-Windows-Web-Player/Conky-Spotify-quot-Now-Playing-quot-scripts/m-p/26825/highlight/true#M216
# https://github.com/mgarratt/spotify-control 

show_commands()
{
    echo "Please use any of the following commands !"
    echo "   play"
    echo "   next"
    echo "   prev"
    echo "   title"
    echo "   artist"
    echo "   album"
    echo "   status"
    echo "   volume up / down"
}

if [ $# -lt 1 ]
then
    show_commands
    exit
fi

volume_percent=5

case $1 in
    "play")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
        ;;
    "next")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next
        ;;
    "prev")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
        ;;
    "title")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$
        ;;
    "artist")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$
        ;;
    "album")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "album"|egrep -v "album"|egrep -v "array"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$
        ;;
    "status")
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus'|grep 'string "[^"]*"'|sed 's/.*"\(.*\)"[^"]*$/\1/'
        ;;
    "volume")
        case $2 in
            "up")
                amixer -D pulse set Master ${volume_percent}%+
                # dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Volume
                ;;
            "down")
                amixer -D pulse set Master ${volume_percent}%-
                ;;
            *)
                echo "choose up or down, does increase by 5%"
                ;;
        esac
        ;;
    *)
        echo "Unknown command: " $1
        show_commands
        ;;
esac
