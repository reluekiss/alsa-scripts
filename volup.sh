#!/bin/bash

# Define the file path
asoundrc_file=~/.asoundrc

# Define the configurations
blueout_config='playback.pcm "blueout"'
softmixer_config='playback.pcm "softmixer"'

# Check if the file exists
if [ -f "$asoundrc_file" ]; then
    # Check if blueout configuration is present
    if grep -q "$blueout_config" "$asoundrc_file"; then
        # Increase volume for blueout
        volume=$(bluealsa-cli volume /org/bluealsa/hci0/dev_F0_D3_1F_78_3D_31/a2dpsrc/sink | grep -oP 'Volume: L: \K[0-9]+ R: \K[0-9]+')
        new_volume=$((volume + 5))
        bluealsa-cli volume /org/bluealsa/hci0/dev_F0_D3_1F_78_3D_31/a2dpsrc/sink "$new_volume" "$new_volume"
    # Check if softmixer configuration is present
    elif grep -q "$softmixer_config" "$asoundrc_file"; then
        # Increase volume for softmixer
        amixer -q set Master 5%+ unmute
    fi
fi
