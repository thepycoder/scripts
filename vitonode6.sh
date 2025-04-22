#!/bin/bash

# SSH login details
USERNAME="sonckv"
# SERVER="sasdslogin02.vito.local"
SERVER="loginnode"
PASSWORD="Iba14jvoec,ej?"

# Prompt user for srun parameters
read -p "Enter amount of memory (in GB): " MEMORY
read -p "Enter number of CPUs per task: " CPUS
read -p "Enter number of GPUs: " GPUS
read -p "Enter amount of hours (integer format): " HOURS

# Convert hours to HH:MM:SS format
TIME_FORMAT=$(printf "%02d:00:00" $HOURS)

# Construct the srun command
COMMAND1="srun --mem=${MEMORY}gb --cpus-per-task=${CPUS} --gpus=${GPUS} --account=cts --partition=cts --time=${TIME_FORMAT} --pty bash"
# COMMAND1="srun --mem=${MEMORY}gb --cpus-per-task=${CPUS} --gpus=${GPUS} -w sasdsnode05 --time=${TIME_FORMAT} --pty bash"
COMMAND2="/softwarestack/apps/hpctools/bin/ssh-server"


# SSH into the server, start a tmux session, and run the first command
sshpass -p $PASSWORD ssh -t $USERNAME@$SERVER "tmux new-session -d -s sonckv-ssh '$COMMAND1'"

# Send the second command to the tmux session
sshpass -p $PASSWORD ssh $USERNAME@$SERVER "tmux send-keys -t sonckv-ssh '$COMMAND2' C-m"

echo "Commands executed in tmux on remote server!"
