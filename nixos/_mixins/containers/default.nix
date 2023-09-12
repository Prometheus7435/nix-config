{config, pkgs, ...}:

{
  imports = [
    # ./nextcloud.nix
    ./gitea.nix
    ./jellyfin.nix
  ];

  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}
