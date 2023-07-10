{config, pkgs, ...}

{
  imports = [
    ./nextcloud.nix
    ./gitea.nix
    ./jellyfin.nix
  ]
}
