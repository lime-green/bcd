#bcd

A linux tool written in perl to go back to a directory matching a pattern. You no longer have to cd ../../.. ...

###How to install

```bash
git clone https://github.com/lime-green/bcd.git
./install.sh
```

No sudo privileges needed. 

###Usage
*Note:* The install script creates an alias 'bd' for 'bcd' so either command will work.

```bash
user@host:/home/josh/projects/stuff/more_stuff$ bcd ts
user@host:/home/josh/projects$ bcd 'h[a-z]{3}'
user@host:/home$ 
```

