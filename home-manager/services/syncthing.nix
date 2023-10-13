{ inputs, outputs, lib, config, pkgs, username... }: {

  services.syncthing = {
    enable = true;
    extraOptions = {
      overrideFolders = false;
      overrideDevices = false;
      user = home-presets.username;
      dataDir = home-presets.homeDirectory;
    };
  };

}
