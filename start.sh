#!/bin/bash

# |||||||||||||||||||||||||||| justClean | version a0.1 |||||||||||||||||||||||||||||||||
# =======================================================================================
# just a silly stupid and small (3 characteristics!) .sh program
# for cleaning MY (my specificly) desktop (NixOS) setup (I'm using to many parenthesis).
#
# (btw, you'll notice I pretty-fied this code too much for it's good... I just like being organized uhh, leave me alone.)
# =======================================================================================

end_program() {

    echo "Ending program..."
    
}

prun_bash_history() {

    echo "Removing bash history..."

    if [ -f "/home/$USER/.bash_history" ];
    then sudo rm /home/$USER/.bash_history
    else echo "Bash history file does not exist! Ignoring..."
    fi

}

prun_bambu_downloads() {

    echo "Removing temporary Bambu Studio files..."

    sudo rm -rf /home/$USER/Downloads/.bambuDownloads
    sudo mkdir -p /home/$USER/Downloads/.bambuDownloads

}

prun_tmp_folder() {

    echo "Removing temporary files older than 7 days (a week)..."

    sudo find /tmp -type f -atime +7 -delete

}

prun_thumbs_folder() {
    
    echo "Removing .thumbs content..."

    sudo rm -rf ~/.thumbs/*

}

prun_cache_folder() {

    echo "Cleaning .cache content older that 7 days (a week)..."

    sudo find ~/.cache/ -depth -type f -atime +7

}

prun_nix_garbage() {
    
    echo "Using nix-collect-garbage..."

    sudo nix-collect-garbage --delete-older-than 7d

}

prun_nix() {

    echo "Doing a nix system deep clean..."

    sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old
    nix-env --delete-generations old
    home-manager remove-generations old

}

prun_nix_store() {

    echo "Optimizing nix store..."

    sudo nix-store --optimize

}

automatic_mode() {

    echo "Starting automatic_mode cleaning chain..."

    prun_bash_history
    prun_tmp_folder
    prun_thumbs_folder
    prun_cache_folder
    prun_nix
    prun_nix_garbage
    prun_nix_store
    end_program

}

echo "For now all this does is clean predefined folders and files..."
echo "Due to that, it's required to be on a NixOS system, or remove the nix prunning function calls."
echo "So be aware, as these are the things it's gonna prun (clean):"
echo "Bash history"
echo ".tmp Folder"
echo ".thumbs Folder"
echo ".cache Folder"
echo "Nix system"
echo "Nix garbage"
echo "Nix store"

automatic_mode