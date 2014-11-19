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
