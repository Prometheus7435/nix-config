{config, pkgs, username, ...}: {
  imports = [
    # ./podman.nix
    ./docker.nix
  ];

  # virtualisation = {
  #   docker = {
  #     enable = true;
  #     rootless = {
  #       enable = true;
  #       setSocketVariable = true;
  #     };
  #   };
  # };

  # users.users.${username}.extraGroups = [ "docker" ];

  # environment.systemPackages = with pkgs; [
  #   docker-compose
  # ];
}
