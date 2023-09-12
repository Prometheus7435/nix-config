{config, pkgs, ...}:

{
  imports = [
    # ./nextcloud.nix
    ./gitea.nix
    ./jellyfin.nix
  ];

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };
}
