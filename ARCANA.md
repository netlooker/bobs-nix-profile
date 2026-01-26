# The Nix Arcana 📜

> *A chronicle of battles fought, bugs squashed, and enlightenment achieved on the path to Nix mastery.*

This document captures the hard-won knowledge from setting up this configuration. May it spare you the suffering.

---

## Chapter 1: The GTK Canberra Incident

**The Problem:** Every GTK app screams `Failed to load module "canberra-gtk-module"` at you.

**The Fix:**
```nix
home.packages = [ pkgs.libcanberra-gtk3 ];

home.sessionVariables = {
  GTK_PATH = "${pkgs.libcanberra-gtk3}/lib/gtk-3.0";
};
```

Don't forget to source session vars in `~/.bashrc`:
```bash
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
```

---

## Chapter 2: The Tilix Keybinding Saga

**The Problem:** GNOME keybindings don't work with Nix-installed apps.

**The Revelation:** GNOME doesn't see Nix paths. You must use the **full absolute path** to the binary:

```nix
command = "${config.home.homeDirectory}/.nix-profile/bin/tilix --quake";
```

**Bonus Pain (Mac + AWS Workspace):** Most keybindings get eaten by macOS or the Workspace client. `Ctrl+;` is one of the few that survives the journey.

---

## Chapter 3: The Catppuccin GTK Tragedy

**The Dream:** Beautiful Catppuccin GTK theme everywhere.

**The Reality:** The GTK theme was [archived upstream](https://github.com/catppuccin/gtk/issues/262). RIP.

**The Consolation:** Icons still work, and you can theme individual apps manually:

```nix
xdg.configFile."tilix/schemes/catppuccin-mocha.json".text = builtins.toJSON {
  name = "Catppuccin Mocha";
  foreground-color = "#CDD6F4";
  background-color = "#1E1E2E";
  palette = [ /* 16 colors */ ];
};
```

---

## Chapter 4: The Fish FZF Rebinding

**The Problem:** `Ctrl+T` is the universal "new tab" shortcut. FZF wants it for file search.

**The Solution:** Rebind in fish config:
```nix
interactiveShellInit = ''
  bind \cf fzf-file-widget    # Ctrl+F for files
  bind -e \ct                  # Unbind Ctrl+T
'';
```

**FZF Shortcuts That Survived:**
| Shortcut | Action |
|----------|--------|
| `Ctrl+R` | Fuzzy history search |
| `Ctrl+F` | Fuzzy file search (rebound) |
| `Alt+C` | Fuzzy cd |

---

## Chapter 5: The Starship Nerd Font Dilemma

**The Problem:** Corporate environments don't have Nerd Fonts. Your prompt looks like hieroglyphics.

**The Solution:** Plain-text symbols for everything:
```nix
programs.starship.settings = {
  git_branch.symbol = "git ";
  python.symbol = "py ";
  nodejs.symbol = "nodejs ";
  nix_shell.symbol = "nix ";
  aws.symbol = "aws ";
  # ... etc
};
```

It's not as pretty, but it works in SSH sessions, AWS Workspaces, and that one VM from 2015.

---

## Chapter 6: The Default Profile Mystery

**The Problem:** Tilix ignores your beautiful profile settings.

**The Revelation:** You must explicitly set the default profile UUID:
```nix
"com/gexperts/Tilix" = {
  default-profile = "2b7c4080-0ddd-46c5-8f23-563fd3ba789d";
};
```

**Finding Your UUID:**
```bash
dconf list /com/gexperts/Tilix/profiles/
```

---

## Chapter 7: The Impure Enlightenment

**The Problem:** Hardcoding usernames in flakes is annoying for team configs.

**The Solution:** Auto-detect with `--impure`:
```nix
username = builtins.getEnv "USER";
homeDirectory = builtins.getEnv "HOME";
```

Yes, it's "impure." No, we don't care. The same flake now works for everyone.

---

## Appendix: Catppuccin Mocha Palette

For when you need to manually theme something:

| Color | Hex |
|-------|-----|
| Base (bg) | `#1E1E2E` |
| Text (fg) | `#CDD6F4` |
| Red | `#F38BA8` |
| Green | `#A6E3A1` |
| Yellow | `#F9E2AF` |
| Blue | `#89B4FA` |
| Magenta | `#F5C2E7` |
| Cyan | `#94E2D5` |

---

## Useful Incantations

```bash
# Rebuild everything
home-manager switch --flake ~/.config/home-manager#default --impure

# Update all flake inputs
nix flake update

# See what generations exist
home-manager generations

# Roll back when things go wrong
home-manager rollback

# Search for packages
nix search nixpkgs <package>

# Dump dconf settings (useful for reverse-engineering)
dconf dump /com/gexperts/Tilix/
```

---

*"In Nix we trust. In flakes we suffer. In reproducibility we find peace."*
