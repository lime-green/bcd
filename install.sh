#!/bin/bash
#
# Install script for bcd

if [[ -f "$HOME/.bash_profile" ]]; then
    profile_file="$HOME/.bash_profile"
else
    profile_file="$HOME/.profile"
fi

# check if the current user's bin is in path 
echo "Checking path..."
echo "$PATH" | tr ':' '\n' | grep "^$HOME/bin$" >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo "~/bin not found in path. Appending path to $profile_file..." 
    cat <<-PROFILE >> $profile_file

	# BCD install.sh (adding path) #
	export PATH="\$PATH:$HOME/bin"
	# END BCD install.sh #
PROFILE
fi

# copy file to current user's bin
echo "Copying file to ~/bin..."
mkdir -p "$HOME/bin"
cp back_directory.pl "$HOME/bin"

# write function and alias to profile_file
echo "Writing function and alias to $profile_file"
cat <<'PROFILE' >> "$profile_file"

# BCD install.sh (adding function and alias) #
bcd() {
    if [[ $# -ne 1 ]]; then
        echo "Invalid number of arguments" 1>&2
    else
        cmd="$(back_directory.pl "$1")"
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
