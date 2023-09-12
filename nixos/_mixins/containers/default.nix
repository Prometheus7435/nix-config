{config, pkgs, ...}:

{
  imports = [
    # ./nextcloud.nix
    ./gitea.nix
    ./jellyfin.nix
  ];

  virtualisation.docker.enable = true;
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}
