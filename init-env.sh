#!/bin/bash
set -e
cd ..

if [ ! -d "git-repo" ]; then
    echo "Clone git-repo..."
    git clone https://gerrit.googlesource.com/git-repo
else
    echo "git-repo already exists, skipping clone"
fi

if [ ! -d ".repo" ]; then
    echo "repo init..."
    ./git-repo/repo init -u https://github.com/n35tef/oe-manifest-odyssey.git -b scarthgap
else
    echo "repo already initialized, skipping init"
fi

echo "repo sync..."
./git-repo/repo sync

if [ ! -L "envsetup.sh" ]; then
    echo "Create symlink to setup env script"
    ln -s layers/meta-st/scripts/envsetup.sh envsetup.sh
else
    echo "envsetup.sh symlink already exists, skipping"
fi

echo "Source setup env script"
DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh --pkg-update --no-ui
