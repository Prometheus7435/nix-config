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
        # config = ./emacs-init.el;
        config = ./emacs-config.org;
        package = pkgs.emacs29;
        # package = pkgs.emacs-unstable;  # rebuilds often
        alwaysEnsure = true;

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
          epkgs.moody
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
          # epkgs.misterioso-theme
          epkgs.use-package
          epkgs.yasnippet-snippets
        ];
      }
    );
  };

  environment.systemPackages = with pkgs; [
    # applications needed for the emacs packages to hook into
    texlive.combined.scheme-full
    nixfmt
  ];

}
