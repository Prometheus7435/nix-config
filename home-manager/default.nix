{ config, desktop, inputs, lib, outputs, pkgs, username, stateVersion, ... }:
{
  imports = [
    ./console
  ]
  ++ lib.optional (builtins.isString desktop) ./desktop
  ++ lib.optional (builtins.isPath (./. + "/users/${username}")) ./users/${username};

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    stateVersion = stateVersion;  # "23.05";
  };

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # inputs.emacs-overlay.overlay
      # outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
#      outputs.overlays.emacs-overlay

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    # package = lib.mkDefault pkgs.unstable.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };
}
