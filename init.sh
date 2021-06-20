#!/bin/sh

HOME=$1
DATA=$2
groupadd ftpgroup
useradd -g ftpgroup -d /dev/null -s /etc ftpuser
/bin/echo -e "a\na" | ./src/pure-pw useradd a -u ftpuser -d /home -f $DATA/pureftpd.passwd
/bin/echo -e "b\nb" | ./src/pure-pw useradd b -u ftpuser -d /home -f $DATA/pureftpd.passwd
/bin/echo -e "c\nc" | ./src/pure-pw useradd c -u ftpuser -d /home -f $DATA/pureftpd.passwd
/bin/echo -e "d\nd" | ./src/pure-pw useradd d -u ftpuser -d /home -f $DATA/pureftpd.passwd
/bin/echo -e "z\nz" | ./src/pure-pw useradd z -u ftpuser -d /home -f $DATA/pureftpd.passwd

# Generate the authentication database
./src/pure-pw mkdb $DATA/pureftpd.pdb -f $DATA/pureftpd.passwd

# Prepare the ftp root directory
mkdir $HOME/a
mkdir $HOME/b
mkdir $HOME/c
mkdir $HOME/c/z
mkdir $HOME/d
mkdir $HOME/e
mkdir $HOME/test
dd if=/dev/urandom of=$HOME/m count=3 bs=3
dd if=/dev/urandom of=$HOME/a/e count=3 bs=3
dd if=/dev/urandom of=$HOME/b/q count=3 bs=3
dd if=/dev/urandom of=$HOME/c/t count=3 bs=3
dd if=/dev/urandom of=$HOME/c/z/t count=3 bs=3
dd if=/dev/urandom of=$HOME/a/e1 count=3 bs=3
dd if=/dev/urandom of=$HOME/test.txt count=3 bs=3
dd if=/dev/urandom of=$HOME/test/test.txt count=3 bs=3
