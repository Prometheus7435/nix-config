#!/usr/bin/env bash

## scripts/install.sh <hostname> <username>
## Ex. sh scripts/install.sh starbase starfleet

set -euo pipefail

TARGET_HOST="${1:-}"
TARGET_USER="${2:-shyfox}"

# TARGET_HOST=""
# TARGET_USER=""

# if [ -n "${1}" ]; then
#   TARGET_HOST="${1}"
# else
#   echo "ERROR! $(basename "${0}") requires a host name:"
#   ls -1 host/ | grep -v ".nix" | grep -v _
#   exit 1
# fi

# case "${TARGET_HOST}" in
#   starbase|akira|fermi|odyssey) true;;
#   *)
#     echo "ERROR! ${TARGET_HOST} is not a supported host"
#     exit 1
#     ;;
# esac

# if [ -n "${2}" ]; then
#   TARGET_USER="${2}"
# else
#   echo "ERROR! $(basename "${0}") requires a user name"
#   ls -1 nixos/_mixins/users | grep -v root
#   exit 1
# fi

# case "${TARGET_USER}" in
#   starfleet|shyfox) true;;
#   *)
#     echo "ERROR! ${TARGET_USER} is not a supported user"
#     exit 1
#     ;;
# esac
if [ ! -d "$HOME/Zero/nix-config/.git" ]; then
  git clone https://github.com/Prometheus7435/nix-config.git "$HOME/Zero/nix-config"
fi

pushd "$HOME/Zero/nix-config"

if [ ! -e "nixos/${TARGET_HOST}/disks.nix" ]; then
  echo "ERROR! $(basename "${0}") could not find the required nixos/${TARGET_HOST}/disks.nix"
  exit 1
fi

# if [ "$(id -u)" -eq 0 ]; then
#   echo "ERROR! $(basename "${0}") should be run as a regular user"
#   exit 1
# fi

echo "WARNING! The disks in ${TARGET_HOST} are about to get wiped"
echo "         NixOS will be re-installed"
echo "         This is a destructive operation"
echo
read -p "Are you sure? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo true

    sudo nix run github:nix-community/disko \
	 --extra-experimental-features 'nix-command flakes' \
	 --no-write-lock-file \
	 -- \
	 --mode zap_create_mount \
	 "nixos/${TARGET_HOST}/disks.nix"

    sudo nixos-install --no-root-password --flake ".#${TARGET_HOST}"

    # Rsync my nix-config to the target install
    # mkdir -p ~/.local/state/nix/profiles
    # mkdir -p "/mnt/home/${TARGET_USER}/Zero/nix-config"
    # rsync -a --delete "${PWD}/" "/mnt/home/${TARGET_USER}/Zero/nix-config/"

    # Rsync nix-config to the target install and set the remote origin to SSH.
    rsync -a --delete "$HOME/Zero/" "/mnt/home/$TARGET_USER/Zero/"
    pushd "/mnt/home/$TARGET_USER/Zero/nix-config"
    git remote set-url origin git@github.com:Prometheus7435/nix-config.git
    popd

    mkdir -p "/mnt/home/${TARGET_USER}/.local/state/nix/profiles"

    ## folders used in my emacs config
    # mkdir -p "/mnt/home/${TARGET_USER}/.config/emacs/backups"
    # mkdir -p "/mnt/home/${TARGET_USER}/.config/emacs/emacs_autosave"
    mkdir -p "/mnt/home/${TARGET_USER}/.config/emacs/{backups,emacs_autosave}"
fi
