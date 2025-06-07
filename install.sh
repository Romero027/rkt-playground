#!/bin/bash

set -e

wget https://download.racket-lang.org/installers/8.17/racket-8.17-x86_64-linux-cs.sh
chmod +x racket-8.17-x86_64-linux-cs.sh
./racket-8.17-x86_64-linux-cs.sh

set +e