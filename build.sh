#!/bin/sh

AFLGO=$LTLP/AFLGo
INC=$LTLP/include
INST_LIB=$LTLP/build/src/instrumentation/libinstrumentation.a
ATM_LIB=$LTLP/build/src/automata/libautomata.a

export LINK_ADDITIONAL="-I $INC $INST_LIB $ATM_LIB"

# Compile the target program
./autogen.sh
CC="/LTL-Fuzzer/AFLGo/afl-clang-fast $LINK_ADDITIONAL" CFLAGS="-O0 -g" ./configure --with-everything --with-cookie --without-privsep --with-nonroot --prefix=/pure-install
make -j50 install-strip

# Set up the virtual users
groupadd ftpgroup
useradd -g ftpgroup -d /dev/null -s /etc ftpuser
/bin/echo -e "a\na" | ./src/pure-pw useradd a -u ftpuser -d /home -f /pureftpd.passwd
/bin/echo -e "b\nb" | ./src/pure-pw useradd b -u ftpuser -d /home -f /pureftpd.passwd
/bin/echo -e "c\nc" | ./src/pure-pw useradd c -u ftpuser -d /home -f /pureftpd.passwd
/bin/echo -e "d\nd" | ./src/pure-pw useradd d -u ftpuser -d /home -f /pureftpd.passwd
/bin/echo -e "z\nz" | ./src/pure-pw useradd z -u ftpuser -d /home -f /pureftpd.passwd

# Generate the authentication database
./src/pure-pw mkdb /pureftpd.pdb -f /pureftpd.passwd

# Prepare the ftp root directory
mkdir /home/a
mkdir /home/b
mkdir /home/c
mkdir /home/c/z
mkdir /home/d
mkdir /home/e
mkdir /home/test
dd if=/dev/urandom of=/home/m count=3 bs=3
dd if=/dev/urandom of=/home/a/e count=3 bs=3
dd if=/dev/urandom of=/home/b/q count=3 bs=3
dd if=/dev/urandom of=/home/c/t count=3 bs=3
dd if=/dev/urandom of=/home/c/z/t count=3 bs=3
dd if=/dev/urandom of=/home/a/e1 count=3 bs=3
dd if=/dev/urandom of=/home/test.txt count=3 bs=3
dd if=/dev/urandom of=/home/test/test.txt count=3 bs=3
