{ config, inputs, pkgs, callPackage, outputs, emacs-overlay, ... }:

{
  imports = [
    # inputs.emacs-overlay
  ];
  services.emacs = {
    enable = true;
    package = pkgs.emacs-unstable;
    # package = pkgs.emacsUnstable; # replace with emacs-gtk, emacsUnstable, or a version provided by the community overlay if desired.
    defaultEditor = true;
  };

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];

  environment.systemPackages = [
    # applications needed for the emacs packages to hook into
    pkgs.python311Full
    pkgs.python311Packages.jedi
    # pkgs.python3Full.jedi
    pkgs.python311Packages.black
    pkgs.python311Packages.jedi-language-server
    pkgs.texlive.combined.scheme-full

  # ];
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-unstable;  # replace with pkgs.emacsPgtk, or another version if desired.
      # config = /home/zach/sync/dot_files/dot_emacs.d/init.el;
      config = ./emacs-config.org; # Org-Babel configs also supported
      alwaysEnsure = true;
      alwaysTangle = true;
      defaultInitFile = true;

    #   # Optionally provide extra packages not in the configuration file.
      extraEmacsPackages = epkgs: [
        epkgs.auto-compile
        epkgs.blacken
        epkgs.company
        epkgs.dashboard
        epkgs.expand-region
        epkgs.flycheck
        epkgs.latex-preview-pane
        epkgs.lsp-jedi
        epkgs.lsp-ui
        epkgs.minions
        epkgs.nix-mode
        epkgs.nix-modeline
        epkgs.org-books
        epkgs.org-chef
        epkgs.popup-kill-ring
        epkgs.rainbow-delimiters
        epkgs.rainbow-mode
        epkgs.spaceline
        epkgs.treemacs-icons-dired
        epkgs.treemacs-magit
        epkgs.treemacs-projectile
        epkgs.underwater-theme
        epkgs.use-package
        epkgs.yasnippet-snippets
      ];
    })
  ];
}
