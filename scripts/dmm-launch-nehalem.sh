#!/bin/bash
# usage: dmm-launch.sh <slug> <prefix> <z-exe> [extra wine args]
# DMM rotation line launcher (DISPLAY :118, q32sup-var, Q32_CPU=max,-avx2,
# PulseAudio tcp 47145). Modeled on win32-compat/scripts/launch-var.sh.
set -u
. "$HOME/workspace/win32-compat/scripts/common.env"
export DISPLAY=:118
export WINEPREFIX="$2"
export Q32_CPU="Nehalem"
export Q32_QEMU="${Q32_QEMU:-$VT/qemu/usr/bin/qemu-i386-static}"
SUP="$HOME/workspace/win32-compat/tools/q32sup-var"
QEMU="$Q32_QEMU -cpu $Q32_CPU -L $VT/sysroot32/root"
export PULSE_SERVER=tcp:127.0.0.1:47145
export PULSE_LATENCY_MSEC=750
WP=$HOME/workspace/win32-perf
export LD_LIBRARY_PATH=$WP/libs32/usr/lib/i386-linux-gnu:$WP/libs32/usr/lib/i386-linux-gnu/pulseaudio
cd "$DMM_CWD" || exit 1
LOG="$HOME/workspace/dmm-trials/logs/$1.log"
setsid nohup $SUP $QEMU "$WINEBIN" "$3" ${@:4} >> "$LOG" 2>&1 &
echo $! > "$HOME/workspace/dmm-trials/logs/$1.pid"
echo "dmm $1 launched pgid $! cpu=$Q32_CPU prefix=$2"
