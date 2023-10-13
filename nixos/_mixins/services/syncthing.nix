{ pkgs, username, ...}: {
# { config, inputs, lib, modulesPath, outputs, pkgs, stateVersion, username, ...}: {
  services = {
    syncthing = {
      enable = true;
      user = "${username}";
      dataDir = "/home/${username}/Sync";    # Default folder for new synced folders
      configDir = "/home/${username}/Sync/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };
}
