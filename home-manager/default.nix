{ config, desktop, inputs, lib, outputs, pkgs, username, stateVersion, ... }:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in {
  # Only import desktop configuration if the host is desktop enabled
  # Only import user specific configuration if they have bespoke settings
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    ./console
#   ./_mixins/console
  ]
  # ++ lib.optional (builtins.isString desktop) ./_mixins/desktop
  # ++ lib.optional (builtins.isPath (./. + "/_mixins/users/${username}")) ./_mixins/users/${username};
  ++ lib.optional (builtins.isString desktop) ./desktop
  ++ lib.optional (builtins.isPath (./. + "/users/${username}")) ./users/${username};

  home = {
    username = username;
    homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";
    sessionPath = [ "$HOME/.local/bin" ];
    stateVersion = "23.05";
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.emacs-overlay
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
