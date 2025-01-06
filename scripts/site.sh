#!/bin/bash

# Define the directory
PRESET_DIR="$HOME/Developer/site"

# Navigate to the preset directory
cd "$PRESET_DIR" || exit

# Start a new tmux session (or attach if it already exists)
SESSION_NAME="site_session"
tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
    # Create a new tmux session
    tmux new-session -d -s $SESSION_NAME -n code

    # First tab: Open nvim in the preset directory
    tmux send-keys -t $SESSION_NAME:code "nvim ." C-m

    # Second tab: Server
    tmux new-window -t $SESSION_NAME -n server
    tmux send-keys -t $SESSION_NAME:server "pnpm run dev" C-m

    # Third tab: Git
    tmux new-window -t $SESSION_NAME -n git
    tmux send-keys -t $SESSION_NAME:git "git status" C-m
fi

# Attach to the session
tmux attach-session -t $SESSION_NAME

