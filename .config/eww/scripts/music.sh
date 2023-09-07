#!/usr/bin/bash

get_cover() {
    mkdir -p "eww_covers"
    cd "eww_covers" || exit

    IMGPATH="cover_art"
    echo "eww_covers/cover_art_default"

    playerctl -F metadata mpris:artUrl 2>/dev/null | while read -r COVER_URL; do
        music_source='󰐍'
        COVER_URL=${COVER_URL//blob:/}
        COVER_URL=${COVER_URL//file:\/\//}
        COVER_URL=${COVER_URL//%20/ }
        if [[ "$COVER_URL" = https* ]]; then
            music_source='󰖟'
            coverurl="$(playerctl metadata mpris:artUrl)"
            coverurl_highres_yt="$(echo $coverurl | sed 's/hqdefault/maxresdefault/g')"
            coverurl_highres_soundcloud="$(echo $coverurl | sed 's/80x80/500x500/g')"

            curl --silent --output "$IMGPATH""_other" "$coverurl" -q –read-timeout=0.1
            cp "$IMGPATH""_other" "$IMGPATH"
            imgsize=$(echo $(du -b ~/.config/eww/eww_covers/cover_art | tr '\t' '\n' | grep -v 'cover_art'))

            if [ "$imgsize" == "0" ] || [ ! "$(diff ~/.config/eww/eww_covers/cover_art ~/.config/eww/eww_covers/cover_art_error)" ]; then
                curl --silent --output "$IMGPATH""_lowres" "$coverurl" -q –read-timeout=0.1
                cp "$IMGPATH""_lowres" "$IMGPATH"
            fi

            echo "eww_covers/cover_art"
        elif [ "$COVER_URL" = "" ]; then
            echo ""
        else
            COVER_URL="${COVER_URL:7}"
            cp "$COVER_URL"  "$IMGPATH"

            echo "eww_covers/'$IMGPATH'"
        fi
    done
}

sanitize() {
	echo "$1" | sed 's/"/\"/g'
}

if [ "$1" = "cover" ]; then
    get_cover
elif [ "$1" == "name" ]; then
    lentolimit=41
    if [ "$2" != "" ]; then
        lentolimit=$2
    fi
    echo '{"artist": "", "title": ""}'
    playerctl -F metadata -f '{{title}}\{{artist}}\' 2>/dev/null | while IFS="$(printf '\\')" read -r title artist; do
                if [[ "$title" == *" - YouTube"* && "$artist" == "" ]]; then
            continue
        elif [[ "$title" == *"YouTube Music" && "$artist" == "" ]]; then
            continue
        fi
        title=$(scripts/limitlen.py "$title" "$lentolimit")
        artist=$(scripts/limitlen.py "$artist" "$lentolimit")

        jq --null-input -r -c \
            --arg artist "$(sanitize "$artist")" \
            --arg title "$(sanitize "$title")" \
            '{"artist": $artist, "title": $title}'

    done
else
    echo "doomed"
fi
