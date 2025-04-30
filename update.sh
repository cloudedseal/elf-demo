#!/bin/bash

# Check arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <filename> <offset> <byte-value-hex>"
    exit 1
fi

FILENAME="$1"
OFFSET_INPUT="$2"
BYTE_HEX="$3"

# Validate file exists
if [ ! -f "$FILENAME" ]; then
    echo "Error: File '$FILENAME' does not exist."
    exit 1
fi

# Convert offset (supports decimal and 0x... hex)
if [[ "$OFFSET_INPUT" == 0x* ]]; then
    OFFSET=$((OFFSET_INPUT))
else
    OFFSET=$OFFSET_INPUT
fi

# Remove '0x' prefix if present from byte value
BYTE_CLEAN=${BYTE_HEX#0x}

# Convert hex byte to decimal
if ! [[ "$BYTE_CLEAN" =~ ^[0-9a-fA-F]{1,2}$ ]]; then
    echo "Error: Invalid hex byte '$BYTE_HEX'. Must be 1 or 2 hex digits."
    exit 1
fi

BYTE_DEC=$((16#$BYTE_CLEAN))

if [ "$BYTE_DEC" -lt 0 ] || [ "$BYTE_DEC" -gt 255 ]; then
    echo "Error: Byte value must be between 0x00 and 0xff."
    exit 1
fi

# Get file size
FILE_SIZE=$(wc -c < "$FILENAME")

if [ "$OFFSET" -ge "$FILE_SIZE" ]; then
    echo "Error: Offset $OFFSET is beyond the file size ($FILE_SIZE bytes)."
    exit 1
fi

# Create a temporary file
TMPFILE=$(mktemp)

# Read original file into temp file
cat "$FILENAME" > "$TMPFILE"

# Write the new byte at the specified offset
printf "\\x$(printf %02x "$BYTE_DEC")" | dd of="$TMPFILE" bs=1 seek="$OFFSET" conv=notrunc &>/dev/null

# Overwrite original file
cat "$TMPFILE" > "$FILENAME"

# Clean up
rm "$TMPFILE"

echo "Updated byte at offset $OFFSET (0x$(printf %x "$OFFSET")) to 0x$(printf %02x "$BYTE_DEC")"