{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers."jellyfin" = {
    autoStart = true;
    image = "lscr.io/linuxserver/jellyfin";
    volumes = [
      "/mnt/vmpool/containers/jellyfin/config:/config"
      "/mnt/vmpool/containers/jellyfin/cache:/cache"
      "/mnt/vmpool/containers/jellyfin/log:/log"
      "/mnt/alpha/media/movies:/movies"
      "/mnt/alpha/media/tv:/tv"
      "/mnt/alpha/media/music:/music"
      "/mnt/alpha/media/webshows:/webshows"
    ];
    # only the 8086 port is required. Others are optional
    ports = [
      "8096:8096"
      "8920:8920"
      "7359:7359/udp"
      "1900:1900/udp"
    ];
    environment = {
      JELLYFIN_LOG_DIR = "/log";
      PUID=1000;
      PGID=1000;
      # TZ=North_America/New_York;
    };
    restart =  unless-stopped;
  };

}
