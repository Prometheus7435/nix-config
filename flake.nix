{
  description =
    "My NixOS config that's 'inspired' from Wimpy's NixOS and Home Manager Configuration basing from the nix-starter-config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # KDE Plasma
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    # TODO: Add any other flake you might need
    nixos-hardware.url = "github:nixos/nixos-hardware";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";

    nix-software-center.url = "github:vlinkz/nix-software-center";

    #TODO: Emacs overlay
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    #TODO: KDE overlay

    # NUR
    nur.url = "github:nix-community/NUR";

    # customize keyboard in Wayland
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = {
    self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-hardware,
      nix-software-center,
      emacs-overlay,
      plasma-manager,
      nur,
      ...
  }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        # "i686-linux"  # I don't have any 32 bit systems
        "x86_64-linux"
        # "aarch64-darwin"  # no MacOS in this house
        # "x86_64-darwin"  # no MacOS in this house
      ];
      # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
      # stateVersion = "unstable";
      stateVersion = "23.05";

    in rec {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; });
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; });

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      # nixosModules = import ./modules/nixos;

      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      # homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        odyssey = nixpkgs.lib.nixosSystem {
          # sudo nixos-rebuild switch --flake $HOME/Zero/nix-config
          specialArgs = {
            inherit inputs outputs stateVersion;
            desktop = "kde";
            hostid = "26dce576"; # head -c 8 /etc/machine-id
            hostname = "odyssey";
            username = "shyfox";
          };
          modules = [ ./nixos ];
        };

        phoenix = nixpkgs.lib.nixosSystem {
          # sudo nixos-rebuild switch --flake $HOME/Zero/nix-config
          specialArgs = {
            inherit inputs outputs stateVersion;
            desktop = "kde";
            hostid = "d7218c78"; # head -c 8 /etc/machine-id
            hostname = "phoenix";
            username = "shyfox";
            # stateVersion = "unstable";
          };
          modules = [
            ./nixos
            nur.nixosModules.nur
          ];
        };

        akira = nixpkgs.lib.nixosSystem {
          # sudo nixos-rebuild switch --flake $HOME/Zero/nix-config
          specialArgs = {
            inherit inputs outputs stateVersion;
            desktop = "kde";
            hostid = "1a74de91"; # head -c 8 /etc/machine-id
            hostname = "akira";
            username = "shyfox";
          };
          modules = [ ./nixos ];
        };

        starbase = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            desktop = null;
            hostid = "2accc22f"; # head -c 8 /etc/machine-id
            hostname = "starbase";
            username = "starfleet";
          };
          modules = [ ./nixos ];
        };

        # named after the Type 6 class shuttle from the Enterprise D
        fermi = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            desktop = null;
            hostid = ""; # head -c 8 /etc/machine-id
            hostname = "fermi";
            username = "starfleet";
          };
          modules = [ ./nixos ];
        };

        cali = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs stateVersion;
            desktop = null;
            hostid = "5da79a16"; # head -c 8 /etc/machine-id
            hostname = "cali";
            username = "starfleet";
          };
          modules = [ ./nixos ];
        };

        # # FIXME replace with your hostname
        # your-hostname = nixpkgs.lib.nixosSystem {
        #   specialArgs = { inherit inputs outputs; };
        #   modules = [
        #     # > Our main nixos configuration file <
        #     ./nixos/configuration.nix
        #   ];
        # };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "shyfox@odyssey" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            desktop = "kde";
            hostname = "odyssey";
            username = "shyfox";
          };
          modules = [ ./home-manager
                      inputs.plasma-manager.homeManagerModules.plasma-manager
                    ];
        };

        "shyfox@phoenix" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            desktop = "kde";
            hostname = "phoenix";
            username = "shyfox";
          };
          modules = [ ./home-manager
                      inputs.plasma-manager.homeManagerModules.plasma-manager
                    ];
        };

        # home-manager switch -b backup --flake $HOME/Zero/nix-config
        "shyfox@akira" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            desktop = "kde";
            hostname = "akira";
            username = "shyfox";
          };
          modules = [ ./home-manager
                      inputs.plasma-manager.homeManagerModules.plasma-manager
                    ];
        };

        "starfleet@starbase" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            desktop = null;
            hostname = "starbase";
            username = "starfleet";
          };
          modules = [ ./home-manager ];
        };

        "starfleet@fermi" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            desktop = null;
            hostname = "fermi";
            username = "starfleet";
          };
          modules = [ ./home-manager ];
        };

        "starfleet@cali" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
            desktop = null;
            hostname = "cali";
            username = "starfleet";
          };
          modules = [ ./home-manager ];
        };
        # # FIXME replace with your username@hostname
        # "your-username@your-hostname" = home-manager.lib.homeManagerConfiguration {
        #   pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        #   extraSpecialArgs = { inherit inputs outputs; };
        #   modules = [
        #     # > Our main home-manager configuration file <
        #     ./home-manager/home.nix
        #   ];
        # };
      };
    };
}
