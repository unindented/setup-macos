#!/bin/sh

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

exists ()
{
  command -v "$1" > /dev/null 2>&1
}

if ! exists pip; then
  echo "Installing pip"
  python3 -m pip install --upgrade pip
fi

if ! exists ansible; then
  echo "Installing ansible"
  python3 -m pip install --user ansible
  ansible-galaxy collection install community.general
fi

ANSIBLE_NOCOWS=1 ansible-playbook $USER.yml --inventory-file inventory --ask-become-pass
