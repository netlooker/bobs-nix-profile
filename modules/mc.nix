{ pkgs, ... }:

{
  # Place the skin in the standard local path where mc definitely looks
  home.file.".local/share/mc/skins/catppuccin-mocha.ini".source = ./skins/catppuccin-mocha.ini;
  
  home.sessionVariables = {
    # Set the default skin for Midnight Commander
    MC_SKIN = "catppuccin-mocha";
  };
}
