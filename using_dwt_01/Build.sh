#!/bin/sh

dmd examples.d @dwt_build_rsp.txt
if [ $? -eq 0 ]; then
 examples.exe
 echo done...
fi
