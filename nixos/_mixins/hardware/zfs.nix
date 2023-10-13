{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
  ];
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    kernelPackages = pkgs.linuxPackages_xanmod_stable
    # kernelPackages = pkgs.linuxKernel.packages.linux_xanmod.zfs
    # kernelPackages = pkgs.linuxPackages_lqx; # zen like kernel
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
