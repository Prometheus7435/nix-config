{ config, desktop, hostname, inputs, lib, modulesPath, outputs, pkgs, stateVersion, username, ...}: {
  # Import host specific boot and hardware configurations.
  # Only include desktop components if one is supplied.
  # - https://nixos.wiki/wiki/Nix_Language:_Tips_%26_Tricks#Coercing_a_relative_path_with_interpolated_variables_to_an_absolute_path_.28for_imports.29
  imports = [
    inputs.disko.nixosModules.disko
    # (./. + "/${hostname}/default.nix")
    # (./. + "/${hostname}/boot.nix")
    # (./. + "/${hostname}/disks.nix")
    # (./. + "/${hostname}/hardware.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    ./_mixins/base
    ./_mixins/boxes
    ./_mixins/languages
    ./_mixins/users/root
    ./_mixins/users/${username}
  ]
  ++ lib.optional (builtins.pathExists (./. + "/${hostname}/boot.nix")) (import ./${hostname}/boot.nix { })
  ++ lib.optional (builtins.pathExists (./. + "/${hostname}/hardware.nix")) (import ./${hostname}/hardware.nix { })

  ++ lib.optional (builtins.pathExists (./. + "/${hostname}/disks.nix")) (import ./${hostname}/disks.nix { })
  ++ lib.optional (builtins.isString desktop) ./_mixins/desktop;

  ++ lib.optional (builtins.pathExists (./. + "/${hostname}/default.nix")) (import ./${hostname}/default.nix { })

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      # outputs.overlays.unstable-packages
      inputs.emacs-overlay.overlay

      ## Figure this out later
      # inputs.plasma-manager.overlay

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

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
    };
  };

  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    optimise.automatic = true;
    # package = pkgs.unstable.nix;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system = {
#    copySystemConfiguration = true;
#    autoUpgrade.enable = true;
    # autoUpgrade.allowReboot = true;
    stateVersion = stateVersion;
    # stateVersion = stateVersion;
  };
}
