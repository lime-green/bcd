#bcd

A linux tool written in perl to go back to a directory matching a pattern.  
No more typing `cd ../../../../..` repeatedly!

`bcd` will change to the directory matching the input pattern. It prioritises directories that are deeper in the tree (excluding the current directory) if there is more than one match.

###Install

```bash
git clone https://github.com/lime-green/bcd.git
cd bcd && source ./install.sh
```

No sudo privileges needed. 

###Usage
*Note:* The install script creates an alias `bd` for `bcd` so either command will work.
General usage is `bcd pattern`. The pattern is treated as a regex pattern, so use single quotes if it contains bash special characters.

```bash
user@host:/home/josh/projects/stuff/more_stuff$ bcd ts
user@host:/home/josh/projects$ bcd 'h[a-z]{3}'
user@host:/home$ 
```

###Inspiration
I was fed up with using `cd ..` repeatedly and I thought there must be a better way. To my surprise, a quick google search didn't show up any results. After writing the code for this project, I did some more digging and found @vigneshwaranr had a project called `bd`. I thought I should share my project anyway because it's more flexible with the pattern matching and will accept any regular expression rather than just looking for the beginning characters. As this is my first public project, I welcome any and all feedback.
