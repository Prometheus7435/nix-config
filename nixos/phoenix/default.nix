# Motherboard:
# CPU: AMD Ryzen 5 PRO 4650U
# GPU: Radeon Graphics
# RAM: 32GB
# NVME: Samsung SSD 980 1TB

{ config, inputs, xremap-flake, lib, pkgs, username, modulesPath, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../_mixins/hardware/default.nix
    ../_mixins/hardware/mobile.nix
    ../_mixins/hardware/network-dhcp.nix
    ../_mixins/hardware/systemd-boot.nix
    ../_mixins/hardware/zfs.nix

    ../_mixins/services/cac.nix
    ../_mixins/services/media-edit.nix
    ../_mixins/services/nfs/client.nix
    ../_mixins/services/pipewire.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    # kernelParams = [ "mem_sleep_default=deep" "nohibernate"];
    kernelModules = [
      "kvm-amd"
    ];
    initrd = {
      availableKernelModules = [
        "sd_mod"
      ];
    };
  };

  hardware = {

  };

  services = {
    # xremap = {
    #   userName = "${username}";  # run as a systemd service in alice
    #   serviceMode = "user";  # run xremap as user
    #   config = {
    #     modmap = [
    #       name = "Global";
    #       remap = { "CapsLock" = "Ctrl"; };  # globally remap CapsLock to Ctrl
    #     ];
    #   };
    # };

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
  # environment.systemPackages = with pkgs; [
  environment.systemPackages = [
    pkgs.cbonsai
  ];
}
