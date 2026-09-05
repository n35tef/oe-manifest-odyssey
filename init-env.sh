#1/bin/bash

set -e

echo "Clone git-repo..."
git clone https://gerrit.googlesource.com/git-repo
echo "repo init..."
./git-repo/repo init -u https://github.com/n35tef/oe-manifest-odyssey.git 
  -b scarthgap
echo "repo sync..."
./git-repo/repo sync
echo "Create symlink to setup env script"
ln -s layers/meta-st/scripts/envsetup.sh envsetup.sh
echo "Source setup env script"
yes | DISTRO=openstlinux-weston MACHINE=stm32mp1 source layers/meta-st/scripts/envsetup.sh --pkg-update --no-ui
