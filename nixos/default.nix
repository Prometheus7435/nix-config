{ config, desktop, hostname, inputs, lib, modulesPath, stateVersion, username, ...}: {
# { config, desktop, hostname, inputs, lib, modulesPath, outputs, pkgs, stateVersion, username, ...}: {
  # - https://nixos.wiki/wiki/Nix_Language:_Tips_%26_Tricks#Coercing_a_relative_path_with_interpolated_variables_to_an_absolute_path_.28for_imports.29
  imports = [
    inputs.disko.nixosModules.disko
    (./. + "/${hostname}/default.nix")
    (./. + "/${hostname}/disks.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    ./_mixins/base
    ./_mixins/languages
    ./_mixins/users/${username}
  ]
  # Only include desktop components if one is supplied.
  ++ lib.optional (builtins.isString desktop) ./_mixins/desktop;

  nixpkgs = {
    overlays = [
      inputs.emacs-overlay.overlay
      inputs.nur.overlay
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

    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system = {
    stateVersion = stateVersion;
  };
}
