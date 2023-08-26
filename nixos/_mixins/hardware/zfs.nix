{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
  ]
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_lqx;

  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
