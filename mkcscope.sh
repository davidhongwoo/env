#!/bin/sh

ctags -R
rm -rf cscope.out cscope.files

find . \( -name '*.cpp' -o -name '*.c' -o -name '*.h' -o -name '*.s' -o -name '*.S' \) -print > cscope.files

#cscope -i cscope.files

#to skip ctrl+d. 
cscope -i -k cscope.files
cscope -b -f cscope.out

