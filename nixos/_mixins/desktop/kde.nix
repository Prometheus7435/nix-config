{ inputs, pkgs, username, ... }: {
  imports = [

  ];

  services = {
    accounts-daemon.enable = true;
    desktopManager = {
      plasma6 = {
        enable = true;
        enableQt5Integration = true;
        # notoPackage = true;
      };
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "${username}";
      };
      defaultSession = "plasma"; # "plasmawayland";
      sddm.wayland.enable = true;
    };

    libinput.enable = true;

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.options = "grp:win_space_toggle";
    };

  };

  programs = {
    dconf = {
      enable = true;
    };
    kdeconnect = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.applet-window-buttons6
    kdePackages.baloo
    kdePackages.discover
    kdePackages.dragon
    kdePackages.filelight
    kdePackages.kalk
    kdePackages.kdeconnect-kde
    kdePackages.kdecoration
    kdePackages.kdeplasma-addons
    kdePackages.kfind
    kdePackages.okular
    kdePackages.plasma-integration
    kdePackages.plasma-pa
    kdePackages.qtstyleplugin-kvantum
    kdePackages.xdg-desktop-portal-kde

    kdePackages.yakuake
    kdePackages.kate
  ];
}
