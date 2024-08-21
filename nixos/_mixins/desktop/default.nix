{ config, inputs, desktop, pkgs, ... }: {
  imports = [
    # ../services/cups.nix
    # ../services/flatpak.nix
    # ../services/sane.nix
    ../services/nextcloud/client.nix
    # ../base/emacs-config.nix
    (./. + "/${desktop}.nix")
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
    # fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "UbuntuMono"]; })
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
    ];
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
    };
  };

  # services = {
  #   xserver.libinput.enable = true;
  # };

  environment.systemPackages = [
    pkgs.alacritty
    pkgs.vlc
    pkgs.chromium
    pkgs.libreoffice
    pkgs.thunderbird
    pkgs.calibre
    # config.nur.repos.wolfangaukang.vdhcoapp # to get it to work, you need to run path/to/net.downloadhelper.coapp install --user
    pkgs.ventoy
  ];
}
