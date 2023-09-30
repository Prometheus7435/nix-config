# Motherboard:
# CPU: AMD Ryzen 5 PRO 4650U
# GPU: Radeon Graphics
# RAM: 32GB
# NVME: Samsung SSD 980 1TB

{ config, inputs, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
    ../_mixins/services/pipewire.nix
    ../_mixins/services/cac.nix
    ../_mixins/services/nfs/client.nix
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/mobile.nix
    ../_mixins/hardware/zfs.nix
    ../_mixins/hardware/systemd-boot.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    # supportedFilesystems = [ "xfs" ];
    # zfs.requestEncryptionCredentials = true;
    # kernelPackages = pkgs.linuxPackages_lqx;
    kernelParams = [ "mem_sleep_default=deep" "nohibernate"];
  };

  hardware = {

  };
  # Enable touchpad support (enabled default in most desktopManager).
  services = {
    # xserver.libinput.enable = true;
    # tlp = {
    #   settings = {
    #     START_CHARGE_THRESH_BAT0 = "75";
    #     STOP_CHARGE_THRESH_BAT0 = "95";
    #   };
    # };
    # fingerprint reader
    fprintd.enable = true;
    fstrim.enable = true;
  };
  security = {
    pam.services.login.fprintAuth = true;
    pam.services.xscreensaver.fprintAuth = true;
  };
  environment.systemPackages = with pkgs; [
    nvtop-amd
    cbonsai
    xorriso
  ];

}
