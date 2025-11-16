#!/bin/bash

# Function to convert RGBA to 0xAARRGGBB format
rgba_to_hex() {
  local rgba_value="$1"
  # Trim whitespace
  rgba_value=$(echo "$rgba_value" | xargs)

  # Regex to match rgba(r, g, b, a)
  if [[ $rgba_value =~ ^rgba\([[:space:]]*([0-9]+)[[:space:]]*,[[:space:]]*([0-9]+)[[:space:]]*,[[:space:]]*([0-9]+)[[:space:]]*,[[:space:]]*([0-9]*\.?[0-9]+)[[:space:]]*\)$ ]]; then
    local r="${BASH_REMATCH[1]}"
    local g="${BASH_REMATCH[2]}"
    local b="${BASH_REMATCH[3]}"
    local a="${BASH_REMATCH[4]}"

    # Convert alpha from 0–1 to 0–255 and round
    a_int=$(echo "scale=0; $a * 255 / 1" | bc)
    a_hex=$(printf "%02X" "$a_int")

    # Convert RGB to hex
    r_hex=$(printf "%02X" "$r")
    g_hex=$(printf "%02X" "$g")
    b_hex=$(printf "%02X" "$b")

    # Output in 0xAARRGGBB format
    echo "0x${a_hex}${r_hex}${g_hex}${b_hex}"
  else
    echo "Error: Invalid RGBA format. Expected: rgba(r, g, b, a)"
    return 1
  fi
}

# Prompt user for input
read -p "Enter RGBA value (e.g., rgba(183, 94, 255, 0.12)): " rgba_input

# Call function and display result
result=$(rgba_to_hex "$rgba_input") && echo "$result" || exit 1
