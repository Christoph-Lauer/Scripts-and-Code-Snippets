#!/bin/sh

# @file         setPowerAndSleepSettings.sh
# @version      1.0
# @date         2021
# @modification (last) 30.10.2024
# @note         adaption for macos 14 sonoma
# @author       Christoph Lauer
# @shell        bash/sh
# @see          https://en.wikipedia.org/wiki/Pmset 
# @license      GNU GPL 3
#
# @BRIEF        This seems to be the ideal settings for the MacBook M1, the 
#               CalDigit TS3+ Dock and the Samsung CRG9 Widescreen monitor
#               to prevent permanent wakeup of the monitor and the dock.

sudo pmset -a standby 0
sudo pmset -a autopoweroff 0 
sudo pmset -a hibernatemode 3
sudo pmset -a ttyskeepawake 0
sudo pmset -a womp 0
sudo pmset -a ring 0
sudo pmset -a proximitywake 0
sudo pmset -a acwake 0
sudo pmset -a sms 0
sudo pmset -a networkoversleep 0
sudo pmset -c gpuswitch 1
sudo pmset -a powernap 0
sudo pmset -a tcpkeepalive 0
sudo pmset -a darkwakes 0 (is this a hidden pareameter?)

pmset -g assertions
pmset -g log | grep "DarkWake" | tail -10
pmset -g
