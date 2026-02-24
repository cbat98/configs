{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      fs = "du -h --max-depth=1";
      gs = "git status";
      ll = "eza -la";
      lt = "eza -TL 2";
      please = "sudo";
    };

    initExtra = ''
      tw() {
          local dir="''${1:-.}"
          fastmod '[ \t]+$' ''' --dir "$dir"
      }
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    configFile = "/home/charlie/repos/configs/oh-my-posh/rainbow.omp.json";
  };

  programs.btop.enable = true;

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    git = true;
  };

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "CaskaydiaCove Nerd Font";
      font_size = 13;
      background_opacity = "0.8";
      enable_audio_bell = false;
    };
  };

  programs.tmux = {
    enable = true;
    prefix = "C-SPACE";
    baseIndex = 1;
    extraConfig = ''
      set -g mode-keys vi
      set -g status-position top
      set -g status-justify left
      set -g status-style "bg=default"
      set -g status-left "TMUX: "
      set -g window-status-current-style "fg=blue bold"
      set -g status-right ""
    '';
  };
}
