#!/bin/bash

# Define the file path
asoundrc_file=~/.asoundrc

# Define the configurations
blue_pcm='playback.pcm "blueout"'
hw_pcm='playback.pcm "softmixer"'
blue_loop='hw:Loopback,1,1'
hw_loop='hw:Loopback,1,0'

# Check if the file exists
if [ -f "$asoundrc_file" ]; then
    # Check if blueout configuration is present
    if grep -q "$blue_pcm" "$asoundrc_file"; then
        # Replace blueout with softmixer
        sed -i -e 's/'"$blue_pcm"'/'"$hw_pcm"'/g' -e 's/'"$blue_loop"'/'"$hw_loop"'/g' "$asoundrc_file"
    # Check if softmixer configuration is present
    elif grep -q "$hw_pcm" "$asoundrc_file"; then
        # Replace softmixer with blueout
        sed -i -e 's/'"$hw_pcm"'/'"$blue_pcm"'/g' -e 's/'"$hw_loop"'/'"$blue_loop"'/g' "$asoundrc_file"
    fi
fi
