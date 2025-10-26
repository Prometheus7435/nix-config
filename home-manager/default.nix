{ config, desktop, inputs, lib, outputs, pkgs, username, stateVersion, emacs-overlay, ... }:
{
  imports = [
    ./console
  ]
  # ++ lib.optional (builtins.isString desktop) ./desktop
  ++ lib.optional (builtins.isPath (./. + "/users/${username}")) ./users/${username};

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    stateVersion = stateVersion;
  };

  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
    ];
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };
  programs.home-manager.enable = true;

  # programs.eza.icons = "auto";
}
