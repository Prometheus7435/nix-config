{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
  ];
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_xanmod;
    # kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  };

  services = {
    # zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
