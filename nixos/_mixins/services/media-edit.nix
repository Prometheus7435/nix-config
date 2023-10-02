{ lib, pkgs, ...}: {
  imports = [

  ];

  environment.systemPackages = with pkgs; [
    unzip

    # video
    ffmpeg_6-full
    yt-dlp
    makemkv
    handbrake

    # audio
    ardour
    audacity
  ];


}
