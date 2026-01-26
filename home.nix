{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/tilix.nix
  ];

  # Catppuccin theme (global)
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # GTK (icons via catppuccin)
  gtk.enable = true;

  programs.home-manager.enable = true;
}

