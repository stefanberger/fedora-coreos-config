#!/usr/bin/env bash

find /usr/ /etc/ \( -executable -o -name '*.so*' \) -type f -exec echo '{}' \; | xargs ls -Z > all-executables
