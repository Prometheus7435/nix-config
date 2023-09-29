{ inputs, pkgs, username, ... }: {
  imports = [
    # inputs.plasma-manager.overlay
    ../services/networkmanager.nix
    # ./plasma-config.nix
  ];

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "dvorak,";
      # xkbOptions = "grp:win_space_toggle";

      desktopManager = {
        plasma5 = {
          enable = true;
        };
      };

      displayManager = {
        # sddm.enable = true;
        lightdm.enable = true;
        defaultSession = "plasmawayland";
        autoLogin = {
          enable = true;
          user = "${username}";
        };
      };
      libinput.enable = true;
    };

  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };

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
    libsForQt5.plasma-integration
    libsForQt5.discover
    libsForQt5.kdeconnect-kde
    libsForQt5.applet-window-buttons
    libsForQt5.kalk
    # libsForQt5.kdecoration
    okular
    yakuake
    kate
  ];

  # services.xserver.desktopManager.plasma5.useQtScaling = true;
}
