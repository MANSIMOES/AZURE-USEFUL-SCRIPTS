#!/bin/bash
# --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Purpose:  To be allocated to a server directoy , in order to be executed from a cronjob. 
#           Based on a given directory, it will continuously move files and directories to a specefied directory.
# Author:   Marcos NOVAIS SIMOES
# --------------------------------------------------------------------------------------------------------------------------------------------------------------
# Change Log
# Date          Author                  Summmary                                                                                    Version
# 24/10/2020    Marcos NOVAIS SIMOES    Creation of first code .                                                                    0.001
# --------------------------------------------------------------------------------------------------------------------------------------------------------------

# VARIABLES ----------------------------------------------------------------------------------------------------------------------------------------------------
WORKING_DIRECTORY="/C/Users/mnova/source/server01/" # The Working Directory is where all required related files are stored.
FILE_A_AUDIT="${WORKING_DIRECTORY}FilesRovesAuditLog.txt" # All activity is reported to this file. The script will create it, if not.
WORKING_DIRECTORY_STORAGE="${WORKING_DIRECTORY}MNS_STORAGE/" # Files to be processed must be in MNS_STORAGE
TARGET_DIRECTORY="/C/Users/mnova/source/server01/Target/"
# Activity -----------------------------------------------------------------------------------------------------------------------------------------------------
# Check 1 : In Working Directory, we check for the folder's avaliability.
if [ ! -d "$WORKING_DIRECTORY" ]; then
  echo "Job stopped because of Check 1 : the working directoy is not valid."
else
    # Check 2 : Within the working directoy, we check for the log file: create it, if not.
    if [ -f "$FILE_A_AUDIT" ]; then
        echo "[$(date)]: Log File ($FILE_A_AUDIT) exists. Adding an entry..."
        echo "[$(date)]: Started by User $(id -u -n) with ID $(id -u)."  >> $FILE_A_AUDIT
    else 
        echo "[$(date)]: Log File ($FILE_A_AUDIT) does not exist."
        echo "[$(date)]: Log File created on $now" >> $FILE_A_AUDIT
        echo "[$(date)]: Started by User $(id -u -n) with ID $(id -u)."  >> $FILE_A_AUDIT
    fi
    # Check 3 : Create a directory for the actual date.
    backup_dir=$(date +'%m%d%Y')
    if [ ! -d "${TARGET_DIRECTORY}${backup_dir}/" ]; then 
        mkdir "${TARGET_DIRECTORY}${backup_dir}/" 
    fi
fi
# Storage -------------------------------------------------------------------------------------------------------------------------------------------------------
# Check 3 : MNS_STORAGE_01 for End-User drop
if [ -d "$WORKING_DIRECTORY_STORAGE" ]; then
  echo "[$(date)]: MNS_STORAGE directory is avaliable. Identifying the files." >> $FILE_A_AUDIT
    for file in $WORKING_DIRECTORY_STORAGE* $WORKING_DIRECTORY_STORAGE**/* ; do
        if [ -f "$file" ]; then
            echo "$file" >> $FILE_A_AUDIT
            mv --backup=numbered "$file" "${TARGET_DIRECTORY}${backup_dir}/"
        fi
    done
    echo "[$(date)]: Operation termianted succesfully." >> $FILE_A_AUDIT
else
    echo "[$(date)]: MNS_STORAGE directory is not avaliable avaliable. No action." >> $FILE_A_AUDIT
fi
# END ------------------------------------------------------------------------------------------------------------------------------------------------------------