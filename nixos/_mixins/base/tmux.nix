{ pkgs, ... }: {
  imports = [

  ];
  programs.tmux = {
    enable = true;
    shortcut = "o";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    clock24 = true;
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = true;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.resurrect
    ];

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
#      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind 2 split-window -h -c "#{pane_current_path}"
      bind 3 split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
