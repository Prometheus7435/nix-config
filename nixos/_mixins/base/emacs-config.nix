{ config, inputs, pkgs, callPackage, outputs, emacs-overlay, ... }:

{
  imports = [

  ];

  services.emacs = {
    enable = true;
    install = true;
    defaultEditor = true;
  # };
  # environment.systemPackages = [
    package = with pkgs; (emacsWithPackagesFromUsePackage
      {
    # pkgs.emacsWithPackagesFromUsePackage

        config = ./emacs-init.el;
        # config = ./emacs-config.org;
        package = pkgs.emacs-pgtk;
        # package = pkgs.emacs-unstable;  # rebuilds often

        # By default emacsWithPackagesFromUsePackage will only pull in
        # packages with `:ensure`, `:ensure t` or `:ensure <package name>`.
        # Setting `alwaysEnsure` to `true` emulates `use-package-always-ensure`
        # and pulls in all use-package references not explicitly disabled via
        # `:ensure nil` or `:disabled`.
        # Note that this is NOT recommended unless you've actually set
        # `use-package-always-ensure` to `t` in your config.
        alwaysEnsure = true;

        # For Org mode babel files, by default only code blocks with
        # `:tangle yes` are considered. Setting `alwaysTangle` to `true`
        # will include all code blocks missing the `:tangle` argument,
        # defaulting it to `yes`.
        # Note that this is NOT recommended unless you have something like
        # `#+PROPERTY: header-args:emacs-lisp :tangle yes` in your config,
        # which defaults `:tangle` to `yes`.
        alwaysTangle = true;

      # }
    # );
    # emacsPkgs.withPackages (epkgs: (with epkgs.melpaStablePackages; [
      extraEmacsPackages = epkgs: [
          epkgs.auto-compile
          epkgs.blacken
          epkgs.company
          epkgs.darktooth-theme
          epkgs.dashboard
          epkgs.environ
          epkgs.expand-region
          epkgs.expand-region
          epkgs.flycheck
          epkgs.flymake
          epkgs.flymake-aspell
          epkgs.helm
          epkgs.helm-core
          epkgs.helm-dictionary
          epkgs.helm-ispell
          epkgs.helm-org
          epkgs.ini-mode
          epkgs.jinx
          epkgs.kaolin-themes
          epkgs.latex-preview-pane
          epkgs.lsp-jedi
          epkgs.lsp-mode
          epkgs.lsp-ui
          epkgs.minions
          epkgs.moody
          epkgs.nix-mode
          epkgs.nix-modeline
          epkgs.org-books
          epkgs.org-chef
          epkgs.popup-kill-ring
          epkgs.projectile
          epkgs.rainbow-delimiters
          epkgs.rainbow-mode
          epkgs.reformatter
          # epkgs.ruff-format
          epkgs.spaceline
          epkgs.sqlite3
          epkgs.treemacs-icons-dired
          epkgs.treemacs-magit
          epkgs.treemacs-projectile
          epkgs.underwater-theme
          epkgs.use-package
          epkgs.yaml-mode
          epkgs.yasnippet-snippets
          epkgs.which-key
          # ]));
      ];
      }
    );
  };

  environment.systemPackages = with pkgs; [
    # applications needed for the emacs packages to hook into
    texlive.combined.scheme-full
    nixfmt
    ispell
    aspell
    black
  ];

}
