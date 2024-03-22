{ config, pkgs, ... }:

{
  home.username = "arun";
  home.homeDirectory = "/home/arun";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [];
  home.file = {};
  home.sessionVariables = {};
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "arun5309";
    userEmail = "arun5309@gmail.com";
    lfs = {
      enable = true;
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
