#!/usr/bin/bash

while true; do
  freeH=$(free -h --si | rg "Mem:")
  swapfreeH=$(free -h --si | rg "Swap:")
  used="$(echo "$freeH" | awk '{ print $3 }')"
  swapused="$(echo "$swapfreeH" | awk '{ print $3 }')"
  perc=$(printf '%.1f' "$(free -m | rg Mem | awk '{print ($3/$2)*100}')")

  echo '{ "used": "'"$used"'", "swapused": "'"$swapused"'", "percentage": '"$perc"' }'

  sleep 5
done
