{ config, inputs, desktop, pkgs, ... }: {
  imports = [
    ../services/cups.nix
    ../services/flatpak.nix
    ../services/sane.nix
    ../services/nextcloud/client.nix
    (./. + "/${desktop}.nix")
  ];

  # boot.kernelParams = [ "quiet" ];
  # boot.plymouth.enable = true;

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
    # fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "UbuntuMono"]; })
      # joypixels
      liberation_ttf
      ubuntu_font_family
      work-sans
      source-code-pro
      fira-code
      fira-code-symbols
      fira
      cooper-hewitt
      ibm-plex
      iosevka
      spleen
      powerline-fonts
      # nerdfonts
    ];
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
    # steam = {
    #   enable = true;
    # };
  };

  services = {
    xserver.libinput.enable = true;
  };

  environment.systemPackages = [
    pkgs.alacritty
    pkgs.vlc
    pkgs.chromium
    # pkgs.google-chrome
    # pkgs.via
    pkgs.libreoffice
    pkgs.thunderbird

    pkgs.v4l-utils  # collection of device drivers and an API for supporting realtime video capture on Linux systems

    pkgs.calibre

    # config.nur.repos.wolfangaukang.vdhcoapp # to get it to work, you need to run path/to/net.downloadhelper.coapp install --user

    pkgs.ventoy

    # pkgs.packagekit
    # pkgs.appflowy
  ];

    # use fonts specified by user rather than default ones
    # enableDefaultFonts = false;

    # fontconfig = {
    #   antialias = true;
    #   cache32Bit = true;
    #   defaultFonts = {
    #     serif = [ "Work Sans" "Joypixels" ];
    #     sansSerif = [ "Work Sans" "Joypixels" ];
    #     monospace = [ "FiraCode Nerd Font Mono" ];
    #     emoji = [ "Joypixels" ];
    #   };
    #   enable = true;
    #   hinting = {
    #     autohint = false;
    #     enable = true;
    #     style = "hintslight";
    #   };
    #   subpixel = {
    #     rgba = "rgb";
    #     lcdfilter = "light";
    #   };
    # };
  # };

  # Accept the joypixels license
  # nixpkgs.config.joypixels.acceptLicense = true;
}
