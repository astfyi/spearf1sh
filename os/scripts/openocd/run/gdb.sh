#!/bin/bash
../../../work/host/bin/arm-linux-gdb -tui --eval-command="target extended-remote localhost:3333" --eval-command="layout asm"
