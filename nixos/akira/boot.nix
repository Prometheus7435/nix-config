{ config, lib, pkgs, modulesPath, ... }: {

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
      #   configurationLimit = 7;
      #   # memtest86 = {
      #   #   enable = true;
      #   # };
      # };
      # efi = {
      #   canTouchEfiVariables = true;
      # };
      # timeout = 3;
    };

#    zfs.forceImportRoot = false;
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;

    kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    # kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [ "mem_sleep_default=deep" "mitigations=off"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
    ];

    kernelModules = [
      "acpi_call"
      "kvm-intel"
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

      ];
    };
  };

  services = {
    zfs.autoScrub.enable = true;
    fstrim.enable = true;
  };
}
