{ config, desktop, hostname, inputs, lib, modulesPath, outputs, pkgs, stateVersion, username, ...}: {
  # - https://nixos.wiki/wiki/Nix_Language:_Tips_%26_Tricks#Coercing_a_relative_path_with_interpolated_variables_to_an_absolute_path_.28for_imports.29
  imports = [
    inputs.disko.nixosModules.disko
    (./. + "/${hostname}/default.nix")
    (./. + "/${hostname}/disks.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    ./_mixins/base
    ./_mixins/boxes
    ./_mixins/languages
    ./_mixins/users/root
    ./_mixins/users/${username}
  ]
  # Only include desktop components if one is supplied.
  ++ lib.optional (builtins.isString desktop) ./_mixins/desktop;

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages
      inputs.emacs-overlay.overlay
      inputs.nur.overlay

      ## Figure this out later
      # inputs.plasma-manager.overlay
    ];
    config = {
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
  };
}
