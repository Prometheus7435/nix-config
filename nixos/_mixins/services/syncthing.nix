{ pkgs, username, ...}: {

  environment.systemPackages = [
    pkgs.syncthing
    pkgs.syncthingtray
  ];

  services = {
    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}/Sync";    # Default folder for new synced folders
      configDir = "/home/${username}/Sync/.config/syncthing";   # Folder for Syncthing's settings and keys
      # overrideFolders = true;
      devices = {
        "Pixel-6a" = { id = "X4VO5OM-XASGNWQ-2MRUUWD-CU76ZIA-XTEUF2Y-TK6M2EQ-F46XW2W-4POPNQX"; };
        "Phoenix" = { id = "WJCKPSS-UX74MSX-K5H2QKL-UNZK6G2-BOGSC7I-NI6GAL7-UMP77JH-BPYL5AG"; };
      };
      folders = {
        "personal" = {        # Name of folder in Syncthing, also the folder ID
          path = "/home/${username}/Sync/personal";    # Which folder to add to Syncthing
          devices = [ "Pixel-6a"  "Phoenix"];
          ignorePerms = false;
        };
        "org" = {        # Name of folder in Syncthing, also the folder ID
          path = "/home/${username}/Sync/org";    # Which folder to add to Syncthing
          devices = [ "Pixel-6a"  "Phoenix"];
          ignorePerms = false;
        };
        "dot_files" = {        # Name of folder in Syncthing, also the folder ID
          path = "/home/${username}/Sync/dot_files";    # Which folder to add to Syncthing
          devices = [ "Pixel-6a"  "Phoenix"];
          ignorePerms = false;
        };
        "Camera" = {        # Name of folder in Syncthing, also the folder ID
          path = "/home/${username}/Sync/Camera";    # Which folder to add to Syncthing
          devices = [ "Pixel-6a"  "Phoenix"];
          ignorePerms = false;
        };
      };
    };
  };
}
