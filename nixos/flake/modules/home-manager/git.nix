{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Charlie B";
      user.email = "charlie@charliebatten.co.uk";
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}
