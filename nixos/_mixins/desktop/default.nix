{ desktop, pkgs, ... }: {
  imports = [
    ../services/cups.nix
    ../services/flatpak.nix
    ../services/sane.nix
    (./. + "/${desktop}.nix")
  ];

  boot.kernelParams = [ "quiet" ];
  boot.plymouth.enable = true;

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
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
      # package = pkgs.unstable.firefox;
    };
    steam = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vlc
    handbrake
    chromium
    libreoffice
    # steam
    ffmpeg_6-full
    calibre

    # ccid
    # gnupg-pkcs11-scd
    # pciutils
    # pcsclite
    # pcsctools
    # opensc
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
