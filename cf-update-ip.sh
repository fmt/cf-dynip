#!/bin/bash
BASE_DIR="$(cd "$(dirname "$0")"; pwd)";
export $(egrep -v '^#' "$BASE_DIR/.env" | xargs)

# 1. set local db file
DOT_IP="$BASE_DIR/.ip"

# 2. Retrieve Current Public IP
CURRENT_IP=$(curl -s https://api.ipify.org)

# 3. Read Previous IP from File
CURR_IP=$(cat $DOT_IP)

# 4. Compare IPs
if [ "$CURRENT_IP" != "$CURR_IP" ]; then
  # 4.1 If diff, update DOT_IP file
  echo $CURRENT_IP > $DOT_IP

  # 4.2 Update Cloudflare A-Record
  curl -X PUT "https://api.cloudflare.com/client/v4/zones/"${ZONE_ID}"/dns_records/"${RECORD_ID} \
       -H "Authorization: Bearer "${API_TOKEN} \
       -H "Content-Type: application/json" \
       --data '{"type":"A","name":"'${RECORD_NAME}'","content":"'${CURRENT_IP}'","ttl":1,"proxied":true}'
fi
