{ config, pkgs, callPackage, ... }:

let
  user = "shyfox";
  state-version = "23.05";

  syncthing_user = "zach";

  myhostId = "80acc9dd";  # head -c 8 /etc/machine-id
  myhostName = "starbase";

  # unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
  };
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";

  nixos-hardware = import (builtins.fetchTarball "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz");

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../_mixins/hardware/network-dhcp.nix  # networking with dhcp only
      ./languages/python-config.nix
      ./programs/emacs-config.nix
      ./nfs/nfs-share.nix
      ./default.nix
      import nixos-hardware/supermicro
      # (import "${nixos-hardware}/supermicro")
      # <home-manager/nixos>
      import home-manager/nixos
      # (import "${home-manager}/nixos")
    ];

  # Use GRUB
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 4;
      };
      timeout = 3;
      efi = {
        canTouchEfiVariables = true;
      };
    };

    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;

    kernelParams = [ "mem_sleep_default=deep" ];
    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    kernelModules = [ "kvm-intel" "acpi_call" "kvm-amd"];
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "virtio_balloon" "virtio_blk" "virtio_pci" "virtio_ring" ];
  };

  boot.zfs.extraPools = [ "vmpool" ];

  services.zfs.autoScrub.enable = true;
  services.fstrim.enable = true;

  # NFS drives
  # fileSystems."/mnt/nfs/${user}" = {
  #   device = "10.10.10.11:/atlantis/nfs/zach";
  #   fsType = "nfs";
  #   options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
  # };

  # Networking
  networking = {
    hostId = "${myhostId}";
    hostName = "${myhostName}";
    networkmanager = {
      enable = true;  # Easiest to use and most distros use this by default.
    };
    firewall = {
      enable = false;
    };
  };

  ## Static IP configuration for eth0 interface
  # networking = {
  #   interfaces = {
  #     eth0 = {
  #       ipv4.addresses = [
  #         {
  #         address = "10.10.10.12";
  #         prefixLength = 24;
  #         }
  #       ];
  #     };
  #   };
  #   defaultGateway = "10.10.10.1";
  #   nameservers = [ "10.10.10.1" ];
  #   # networking.defaultGateway = "10.10.10.1";
  #   # networking.nameservers = [ "10.10.10.1" ];
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  services.xserver = {
    enable = true;
    # layout = "us";
  };

  programs.dconf.enable = true;

  nixpkgs.config.allowUnfree = true;

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for FF/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        intel-ocl
        rocm-opencl-icd
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  hardware.bluetooth.enable = true;

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    jack.enable = true;
    pulse.enable = true;
  };
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    initialPassword = "Lancer21";
    extraGroups = [ "wheel" "disk" "libvirtd" "audio" "video" "input" "systemd-journal" "networkmanager" "network"];
    packages = with pkgs; [
      syncthing
      # nextcloud-client
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${user}" = { pkgs, ... }: {

    home.stateVersion = "${state-version}";

    home.packages = with pkgs; [
      # git
      fish
    ];
    programs.bash.enable = true;
    programs.fish = {
      enable = true;
      shellAliases =  {
        swnix = "sudo nixos-rebuild switch --upgrade";
        ednix = "sudo emacs -nw /etc/nixos/configuration.nix";
        restartemacs = "systemctl --user restart emacs";
        edi = "emacsclient -n -c";
        # l = "ls -la";
      };
    };
    programs.git = {
      enable = true;
      userName  = "Zach Bombay";
      userEmail = "zacharybombay@gmail.com";
    };
    };
  };

  # default shell for all users
  users.defaultUserShell = pkgs.fish;

 # Fonts
  fonts.fonts = with pkgs; [
    source-code-pro
    fira-code
    fira
    cooper-hewitt
    ibm-plex
    iosevka
    spleen
    fira-code-symbols
    powerline-fonts
    nerdfonts
  ];

  environment.systemPackages = with pkgs; [

  ];

  # services
  services = {
    openssh = {
      enable = true;
    };
    printing = {
      enable = true;
    };
    # syncthing = {
    #   enable = true;
    #   # user = "zach";
    #   user = "${syncthing_user}";
    #   dataDir = "/home/zach/sync";    # Default folder for new synced folders
    #   configDir = "/home/zach/sync/.config/syncthing";   # Folder for Syncthing's settings and keys
    #   # dataDir = "/home/${syncthing_user}/sync";    # Default folder for new synced folders
    #   # configDir = "/home/${syncthing_user}/sync/.config/syncthing";   # Folder for Syncthing's settings and keys
    # };
    locate = {
      enable = true;
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";
    };

    settings.auto-optimise-store = true;
  };

  system = {
#    copySystemConfiguration = true;
    # autoUpgrade.enable = true;
    # autoUpgrade.allowReboot = true;
    stateVersion = "${state-version}"; # Did you read the comment?
  };
}
