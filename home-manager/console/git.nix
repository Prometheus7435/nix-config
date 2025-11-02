{ pkgs, ... }: {
  programs = {
    delta = {
      enable = true;
      options = {
        features = "decorations";
        navigate = true;
        side-by-side = true;
      };
    };

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
      # settings = {
      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
      # config = {
      #   push = {
      #     default = "matching";
      #   };
      #   pull = {
      #     rebase = true;
      #   };
      #   init = {
      #     defaultBranch = "main";
      #   };
      # };

      # extraConfig = {

      # };

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
