#!/bin/bash
# maintainer "kunal" (kode.techm@gmail.com)
# Updated 2025: Uses curl with Gmail App Passwords for alerting

# --- CONFIGURATION ---
PROCESS_NAME="nginx"
PORT="80"
LOG_FILE="/home/homeuser/nov-2025/git-temp/access.log"
ALERT_FILE="/home/homeuser/nov-2025/git-temp/alerts.log"

# Gmail Credentials (Use an App Password, NOT your regular password)
EMAIL_ID="kode.techm@gmail.com"
APP_PASSWORD="ptof pvph pmcm ekqq" #-character App Password

# --- FUNCTIONS ---
send_email() {
    local SUBJECT="$1"
    local BODY="$2"
    # Port 465 is used for SMTPS (SSL)
    curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
      --mail-from "$EMAIL_ID" \
      --mail-rcpt "$EMAIL_ID" \
      --user "$EMAIL_ID:$APP_PASSWORD" \
      -T <(echo -e "From: $EMAIL_ID\nTo: $EMAIL_ID\nSubject: $SUBJECT\n\n$BODY")
}

# --- MONITORING LOOP ---
while true; do
    if ! ps aux | grep -v grep | grep -q "$PROCESS_NAME"; then
        MSG="Process $PROCESS_NAME is not running."
        echo "$(date): $MSG Sending alert..." >> "$ALERT_FILE"
        send_email "$PROCESS_NAME Alert" "$(date): $MSG"
        
    elif ! ss -tuln | grep -q ":$PORT"; then
        MSG="Port $PORT is not listening."
        echo "$(date): $MSG Sending alert..." >> "$ALERT_FILE"
        send_email "Port $PORT Alert" "$(date): $MSG"
        
    elif ! grep -q "$PROCESS_NAME" "$LOG_FILE"; then
        MSG="No logs found for $PROCESS_NAME in $LOG_FILE."
        echo "$(date): $MSG Sending alert..." >> "$ALERT_FILE"
        send_email "No Logs Alert" "$(date): $MSG"
    fi
    
    sleep 60
done
exit