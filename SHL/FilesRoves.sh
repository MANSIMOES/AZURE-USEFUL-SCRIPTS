#!/bin/bash
# -------------------------------------------------------------------------
# Purpose: Move files from directory A to directoy B, at every 1 minute.
# Author: MNS
# -------------------------------------------------------------------------
# Req.1 AuditLog
# Req.2 Actual Move
# -------------------------------------------------------------------------

# Recording Initiazation in Audit Logs. -----------------------------------
DIR_C_AUDIT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ECHO "[SCRITP OUT]: Current directory is: $DIR_C_AUDIT"
FILE_A_AUDIT="FilesRovesAuditLog.txt"

if [ -f "$FILE_A_AUDIT" ]; then
    echo "[SCRITP OUT]: $FILE_A_AUDIT exists. Creating an entry..."
    echo "[$(date)]: Started by User $(id -u -n) with ID $(id -u)."  >> $FILE_A_AUDIT
else 
    echo "[SCRITP OUT]: $FILE_A_AUDIT does not exist."
    echo "[SCRITP OUT]: File created on $now" >> $FILE_A_AUDIT
    echo "[$(date)]: Started by User $(id -u -n) with ID $(id -u)."  >> $FILE_A_AUDIT
fi

# Checking In-Command
if [ $# -gt 1 ]; then
    echo "[SCRITP OUT]: Your command line contains $# arguments"
    echo "[$(date)]: In-line command provided."  >> $FILE_A_AUDIT
    while [ "$1" != "" ]; do
        case "$1" in 
        ("$1")
            DIR_A_SOURCE="$1/*"
            echo "[$(date)]: DIR_A_SOURCE is $1."  >> $FILE_A_AUDIT;;
        ("$2")
            DIR_B_TARGET="$2/*"
            echo "[$(date)]: DIR_B_TARGET is $2."  >> $FILE_A_AUDIT;;
        esac
        shift
    done
else
    echo "[SCRITP OUT]: Your command line contains no arguments. Exiting..."
    echo "[$(date)]: In-line command not provided. Exited."  >> $FILE_A_AUDIT
    exit 1000000
fi

# Moving the files from Directory A to Directory B. -----------------------
echo "[SCRITP OUT]: Moving files..."
for f in $DIR_A_SOURCE
do
    echo "[SCRITP OUT]: Processing $f file..."
    # take action on each file. $f store current file name
done

# Update Status in Audit Logs. --------------------------------------------