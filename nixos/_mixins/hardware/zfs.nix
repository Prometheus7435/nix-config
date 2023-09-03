{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
  ]
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_lqx; # zen like kernel
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
