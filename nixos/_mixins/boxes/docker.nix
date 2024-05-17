{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  virtualisation.docker.enable = true;
  # virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.users.starfleet.extraGroups = [ "docker" ];
}
