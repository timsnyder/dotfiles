#!/bin/bash

# there isn't a straightforward way to test for fonts being installed so I'm making this a separate
# script
#

set -x
set -e
git clone https://github.com/powerline/fonts.git --depth=1

cd fonts
./install.sh

cd ..
rm -rf fonts
