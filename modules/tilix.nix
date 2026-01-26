{ pkgs, config, ... }:

let
  theme = import ./theme.nix;
  profileUUID = "2b7c4080-0ddd-46c5-8f23-563fd3ba789d";
  tilixBin = "${config.home.homeDirectory}/.nix-profile/bin/tilix";
in
{
  home.sessionVariables = {
    GTK_PATH = "${pkgs.libcanberra-gtk3}/lib/gtk-3.0";
  };

  xdg.configFile."tilix/schemes/catppuccin-mocha.json".text = builtins.toJSON {
    name = "Catppuccin Mocha";
    comment = "Catppuccin Mocha theme";
    foreground-color = theme.colors.text;
    background-color = theme.colors.base;
    palette = theme.palette;
  };

  dconf.settings = {
    "com/gexperts/Tilix" = {
      quake-specific-monitor = 0;
      default-profile = profileUUID;
      quake-height-percent = 50;
    };

    "com/gexperts/Tilix/profiles/${profileUUID}" = {
      visible-name = "Default";
      use-theme-colors = false;
      color-scheme = "catppuccin-mocha";
      background-color = theme.colors.base;
      foreground-color = theme.colors.text;
      background-transparency-percent = 5;
      cursor-shape = "ibeam";
      font = "Monospace 12";
      use-system-font = false;
      login-shell = true;
      use-custom-command = true;
      custom-command = "fish";
      palette = theme.palette;
    };

    "com/gexperts/Tilix/keybindings" = {
      toggle-quake = "<Control>semicolon";
      session-add-right = "<Control>t";
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Tilix Quake";
      command = "${tilixBin} --quake";
      binding = "<Control>semicolon";  # Ctrl+; works well with Mac + AWS Workspace
    };
  };
}
