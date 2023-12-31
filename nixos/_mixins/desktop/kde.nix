{ inputs, pkgs, username, ... }: {
  imports = [
    # ../services/networkmanager.nix
  ];

  services = {
    accounts-daemon.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      # xkbVariant = "dvorak,";
      xkbOptions = "grp:win_space_toggle";

      desktopManager = {
        plasma5 = {
          enable = true;
        };
      };

      displayManager = {
        # sddm.enable = true;
        lightdm.enable = true;  # lets me autoLogin
        defaultSession = "plasmawayland";
        autoLogin = {
          enable = true;
          user = "${username}";
        };
      };
      # libinput.enable = true;
    };

  };
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-mozc
  #     fcitx5-gtk
  #   ];
  # };

  programs = {
    dconf = {
      enable = true;
    };
    kdeconnect = {
      enable = true;
    };
    # plasma = {
    #   enable = true;
    #   # shortcuts = {
    #   #   "ksmserver"."Lock Session" = ["Meta+L" "Screensaver"];
    #   # };
    # };
  };

  # nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    libsForQt5.applet-window-buttons
    libsForQt5.discover
    libsForQt5.dragon
    libsForQt5.kalk
    libsForQt5.kdeconnect-kde
    libsForQt5.kfind
    libsForQt5.plasma-integration
    libsForQt5.xdg-desktop-portal-kde
    libsForQt5.kdecoration
    libsForQt5.qtstyleplugin-kvantum
    okular
    yakuake
    kate
  ];

  # services.xserver.desktopManager.plasma5.useQtScaling = true;
}
