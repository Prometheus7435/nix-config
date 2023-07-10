{ config, ... }: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "" ];
  };
}
