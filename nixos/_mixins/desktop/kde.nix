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
    # displayManager = {
    #   autoLogin = true;
    # };

    xserver = {
      enable = true;
      xkb.layout = "us";
      # xkbVariant = "dvorak,";
      xkb.options = "grp:win_space_toggle";

      # desktopManager = {
      #   plasma5 = {
      #     enable = true;
      #   };
      # };

      displayManager = {
        # sddm = {
        #   enable = true;
        #   wayland.enable = true;
        # };
        # lightdm.enable = true;  # lets me autoLogin
        defaultSession = "plasma"; # "plasmawayland";
        sddm.wayland.enable = true; # new addition
        # autoLogin = {
        #   enable = true;
        #   user = "${username}";
        # };
      };
      # libinput.enable = true;
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
    # kdePackages.applet-window-buttons
    kdePackages.discover
    kdePackages.dragon
    kdePackages.filelight
    kdePackages.kalk
    kdePackages.kdeconnect-kde
    kdePackages.kfind
    kdePackages.plasma-integration
    kdePackages.xdg-desktop-portal-kde
    kdePackages.kdecoration
    kdePackages.qtstyleplugin-kvantum

    libsForQt5.applet-window-buttons
    # libsForQt5.baloo
    # libsForQt5.discover
    # libsForQt5.dragon
    # libsForQt5.filelight
    # libsForQt5.kalk
    # libsForQt5.kdeconnect-kde
    # libsForQt5.kfind
    # libsForQt5.plasma-integration
    # libsForQt5.xdg-desktop-portal-kde
    # libsForQt5.kdecoration
    # libsForQt5.qtstyleplugin-kvantum

    okular
    yakuake
    kate
  ];
}
