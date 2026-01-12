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
    # initExtra = ''
    #   eval "$(oh-my-posh init bash --config ${configDir}/oh-my-posh/rainbow.omp.json)"
    # '';
  };
  
  programs.btop.enable = true;
  
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    git = true;
  };

  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family CaskaydiaCove Nerd Font
      background_opacity 0.8
      enable_audio_bell no
    '';
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
