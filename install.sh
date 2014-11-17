#!/bin/bash
#
# Install script for bcd

# check if the current user's bin is in path 
echo "Checking path..."
echo "$PATH" | tr ':' '\n' | grep "^$HOME/bin$" >/dev/null 2>&1
if [[ $? -ne 0 ]]; then
    echo -e "~/bin is not in your path. Please add the following line to your .profile then re-run this script:\n export \$PATH=\$PATH:~/bin" 1>&2
    echo -e "Then run: source ~/.profile" 1>&2
    exit 1
fi

# copy file to current user's bin
echo "Copying file..."
mkdir -p $HOME/bin
cp back_directory.pl $HOME/bin

# write function and alias to bashrc
echo "Writing to .bashrc..."
cat <<'BASHRC' >> $HOME/.bashrc
bcd() {
cmd=`back_directory.pl $1`;
if [[ $? -eq 0 ]]; then
    eval $cmd;
else
    echo "USAGE: ${FUNCNAME[0]} pattern" 1>&2
    echo -e "\nSearches the current directory path from right to left and changes directory to the first matched pattern" 1>&2
fi
}

alias bd='bcd'
BASHRC

echo -e "\nDone" 
