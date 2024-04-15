{ pkgs, ... }: {
  programs = {
    gh = {
      enable = true;
      extensions = with pkgs; [ gh-markdown-preview ];
      # extensions = with pkgs.unstable; [ gh-markdown-preview ];
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
    };

    git = {
      enable = true;
      userName = "Zach Bombay";
      userEmail = "zacharybombay@gmail.com";
      delta = {
        enable = true;
        options = {
          features = "decorations";
          navigate = true;
          side-by-side = true;
        };
      };

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };

      extraConfig = {
        push = {
          default = "matching";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
      };

      ignores = [
        "*.log"
        "*.out"
        "*.pdf"
        # "*.lock"
        ".DS_Store"
        "bin/"
        "dist/"
        "result"
      ];
    };
  };
}
