{ lib, pkgs, ...}: {
  imports = [

  ];

  environment.systemPackages = with pkgs; [
    unzip
    ffmpeg_6-full
    yt-dlp
    makemkv
    handbrake

    # python3Full
  ];


}
