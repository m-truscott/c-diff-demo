#!/usr/bin/env bash
set -euo pipefail

SNAPSHOT=/tmp/original_compiled
OUT_DIR=out

make clean >/dev/null
make >/dev/null

if [ ! -d "$SNAPSHOT" ]; then
    cp -r "$OUT_DIR" "$SNAPSHOT"
    echo "Stored original build at $SNAPSHOT"
    exit 0
fi

if diff -rq "$SNAPSHOT" "$OUT_DIR"; then
    echo "Match: $OUT_DIR is identical to $SNAPSHOT"
    exit 0
else
    echo "Differences found"
    exit 1
fi
