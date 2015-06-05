#!/bin/bash
#
# Install script for bcd

if [[ -f "$HOME/.bash_profile" ]]; then
    profile_file="$HOME/.bash_profile"
else
    profile_file="$HOME/.profile"
fi

grep "BCD install.sh" "$profile_file"  &> /dev/null
[ $? -eq 0 ] && exit 0

# write function and alias to profile_file
echo "Writing function and alias to $profile_file"
cat <<'PROFILE' >> "$profile_file"

# BCD install.sh (adding function and alias) #
bcd() {
    if [[ $# -eq 0 ]]; then
        eval "cd .."
    else
        cmd="$(back_directory.pl "$1" 2> /dev/null)"
        if [[ $? -eq 0 ]]; then
            eval "$cmd";
        else
            echo "USAGE: ${FUNCNAME[0]} pattern" 1>&2
            echo -e "\nSearches the current directory path from right to left and changes directory to the first matched pattern" 1>&2
        fi
    fi
}

alias bd='bcd'
# END BCD install.sh #
PROFILE

source "$profile_file"
echo -e "\nDone" 
