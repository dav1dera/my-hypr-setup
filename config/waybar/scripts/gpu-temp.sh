#!/usr/bin/env bash

# NVIDIA
if command -v nvidia-smi >/dev/null 2>&1; then
    temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)
    if [ -n "$temp" ]; then
        echo " GPU ${temp}°C"
        exit 0
    fi
fi

# AMD
for hwmon in /sys/class/hwmon/hwmon*; do
    [ -f "$hwmon/name" ] || continue
    name=$(cat "$hwmon/name" 2>/dev/null)
    case "$name" in
        amdgpu)
            if [ -f "$hwmon/temp1_input" ]; then
                temp=$(awk '{print int($1/1000)}' "$hwmon/temp1_input")
                echo " GPU ${temp}°C"
                exit 0
            fi
            ;;
    esac
done

echo " GPU --"
