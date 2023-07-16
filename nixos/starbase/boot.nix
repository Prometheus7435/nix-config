{ config, lib, pkgs, modulesPath, ... }: {
#{ config, lib, pkgs, ... }: {
  boot = {
    loader = {
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiInstallAsRemovable = true;
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 8;
        # splashImage = ./bonsai.png;
      };
      timeout = 3;
      # systemd-boot = {
      #   enable = true;
      #   configurationLimit = 10;
      #   # memtest86 = {
      #   #   enable = true;
      #   # };
      # };
      # efi = {
      #   canTouchEfiVariables = true;
      # };
      # timeout = 3;
    };

    supportedFilesystems = [ "zfs" ];
    zfs = {
      extraPools = [ "vmpool" "alpha"];
      requestEncryptionCredentials = true;
    };

    kernelPackages = pkgs.linuxPackages;
#    kernelParams = [ "mem_sleep_default=deep" ];
    kernelParams = [ "mitigations=off" ];
#    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    extraModulePackages = [];

    kernelModules = [
      # "kvm-intel"
      "acpi_call"
      "kvm-amd"
      "vhost_vsock"
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "virtio_balloon"
        "virtio_blk"
        "virtio_pci"
        "virtio_ring"
        "mpt3sas"
        "nvme"
      ];
      kernelModules = [
        # "amdgpu"
      ];
    };
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
