#!/bin/bash
df / | sed -n '2p' | awk '{printf "%d", $5}'
