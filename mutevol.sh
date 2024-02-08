#!/bin/bash

# Define the file path
asoundrc_file=~/.asoundrc

# Define the configurations
blueout_config='playback.pcm "blueout"'
softmixer_config='playback.pcm "softmixer"'

# Function to mute for blueout configuration
mute_blueout() {
    # Check current mute state
    mute_state=$(bluealsa-cli mute /org/bluealsa/hci0/dev_F0_D3_1F_78_3D_31/a2dpsrc/sink)
    if [[ "$mute_state" == "Muted: L: true R: true" ]]; then
        # Unmute if currently muted
        bluealsa-cli mute /org/bluealsa/hci0/dev_F0_D3_1F_78_3D_31/a2dpsrc/sink false false
    else
        # Mute if currently unmuted
        bluealsa-cli mute /org/bluealsa/hci0/dev_F0_D3_1F_78_3D_31/a2dpsrc/sink true true
    fi
}

# Function to mute for softmixer configuration
mute_softmixer() {
    # Toggle capture state
    amixer -q set Capture toggle
}

# Check if the file exists
if [ -f "$asoundrc_file" ]; then
    # Check if blueout configuration is present
    if grep -q "$blueout_config" "$asoundrc_file"; then
        mute_blueout
    # Check if softmixer configuration is present
    elif grep -q "$softmixer_config" "$asoundrc_file"; then
        mute_softmixer
    fi
fi
