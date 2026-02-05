{ pkgs, ... }:

{
  xdg.configFile."mc/skins/catppuccin-mocha.ini".source = ./skins/catppuccin-mocha.ini;
  
  home.sessionVariables = {
    # Set the default skin for Midnight Commander
    MC_SKIN = "catppuccin-mocha";
  };
}
