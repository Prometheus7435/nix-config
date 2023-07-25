{ config, inputs, pkgs, callPackage, outputs, emacs-overlay, ... }:

{
  imports = [

  ];

  services.emacs = {
    enable = true;
    install = true;
    defaultEditor = true;
    package = with pkgs; (emacsWithPackagesFromUsePackage
      {
        config = ./emacs-init.el;
        # config = ./emacs-config.org;
        # package = pkgs.emacs-git;
        package = pkgs.emacs-unstable;
        alwaysEnsure = false;

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
      }
    );
  };

  environment.systemPackages = with pkgs; [
    # applications needed for the emacs packages to hook into
    python311Full
    python311Packages.jedi
    python311Packages.black
    python311Packages.jedi-language-server

    texlive.combined.scheme-full

    nixfmt
  ];

  #   (emacsWithPackagesFromUsePackage {
  #     # package = pkgs.emacs-unstable;  # replace with pkgs.emacsPgtk, or another version if desired.
  #     # config = /home/zach/sync/dot_files/dot_emacs.d/init.el;
  #     config = ./emacs-config.org; # Org-Babel configs also supported
  #     alwaysEnsure = true;
  #     alwaysTangle = true;
  #     defaultInitFile = true;

  #     # extraEmacsPackages = epkgs: [
  #     #   epkgs.auto-compile
  #     #   epkgs.blacken
  #     #   epkgs.company
  #     #   epkgs.dashboard
  #     #   epkgs.expand-region
  #     #   epkgs.flycheck
  #     #   epkgs.latex-preview-pane
  #     #   epkgs.lsp-jedi
  #     #   epkgs.lsp-ui
  #     #   epkgs.minions
  #     #   epkgs.nix-mode
  #     #   epkgs.nix-modeline
  #     #   epkgs.org-books
  #     #   epkgs.org-chef
  #     #   epkgs.popup-kill-ring
  #     #   epkgs.rainbow-delimiters
  #     #   epkgs.rainbow-mode
  #     #   epkgs.spaceline
  #     #   epkgs.treemacs-icons-dired
  #     #   epkgs.treemacs-magit
  #     #   epkgs.treemacs-projectile
  #     #   epkgs.underwater-theme
  #     #   epkgs.use-package
  #     #   epkgs.yasnippet-snippets
  #     # ];
  #   })
  # ];
}
