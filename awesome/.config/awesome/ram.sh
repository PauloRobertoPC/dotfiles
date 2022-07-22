#!/bin/bash
free -m | grep 'Mem:' | awk '{printf "%d@@%d@", $7, $2}'
