{ pkgs, ... }: {
  imports = [

  ];
  programs.tmux = {
    enable = true;
    # shortcut = "b";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    clock24 = true;
    baseIndex = 1;
    # newSession = true;
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
      bind | split-window -h -c "#{pane_current_path}"
      bind -  split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Configure the catppuccin plugin
      set -g @catppuccin_flavor "mocha" # latte, frappe, macchiato, or mocha
      set -g @catppuccin_window_status_style "rounded" # basic, rounded, slanted, custom, or none

      # Change prefix from 'Ctrl+b' to 'Ctrl+t'
      unbind C-b
      set-option -g prefix C-t
      bind-key C-t send-prefix
    '';
  };
}
