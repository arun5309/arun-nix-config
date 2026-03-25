#!/usr/bin/env sh

wl-copy --clear; copyq remove $(seq 0 1 $(($(copyq count) - 1)))

