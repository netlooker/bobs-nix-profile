# Bob's Nix AWS Config 🐧☁️

> Because life's too short to manually install packages like a caveman.

A **team-ready**, **opinionated** Home Manager configuration for developers who've accepted Nix into their hearts (and terminals). Built for AWS Workspaces but works anywhere you can convince Nix to run.

## What's Inside This Beautiful Mess

```
.
├── flake.nix          # The mothership
├── home.nix           # Where it all comes together
└── modules/
    ├── packages.nix   # Your new best friends
    ├── shell.nix      # Fish + friends (sorry bash)
    ├── tilix.nix      # Terminal eye candy
    └── theme.nix      # Catppuccin Mocha (we have taste)
```

## Features (aka "Why You Should Care")

### 🐟 Fish Shell
Because typing `cd ../../../` is for people who hate themselves. Comes with:
- **zoxide** - `cd` but it actually remembers where you've been
- **fzf** - fuzzy find everything (rebound to `Ctrl+F` because `Ctrl+T` is for Tilix tabs, fight me)
- **starship** - pretty prompt with plain-text symbols (no nerd fonts required, you're welcome IT department)

### 🛠️ Modern CLI Tools
We replace the classics with tools that don't make you want to cry:

| Old & Busted | New Hotness |
|--------------|-------------|
| `cat` | `bat` (with syntax highlighting!) |
| `ls` | `eza` (colors! icons! trees!) |
| `grep` | `ripgrep` (actually fast) |
| `find` | `fd` (human-friendly) |
| `cd` | `zoxide` (it learns) |

### 🎨 Catppuccin Mocha Theme
Applied globally because consistency is king. Your eyes will thank you at 2 AM.

### 📦 Batteries Included
- **lazygit** / **lazydocker** - TUI for people who forgot the CLI flags
- **direnv** + **nix-direnv** - per-project environments that just work™
- **delta** - git diffs that don't look like they're from 1995
- **btop** - `htop` but prettier
- **jq** / **yq** - because YAML and JSON are everywhere
- **just** - command runner for sanity

### 🤖 Agentic Tooling
Ready for AI engineering out of the box:
- **Python Data Stack**: `numpy`, `scipy`, `pandas` (system-level optimization)
- **Media**: `ffmpeg`, `yt-dlp` (audio/video processing)
- **Vector DB**: `sqlite-vec` (local vector search extension)
- **Networking**: `tailscale` (secure mesh for exposing agents)
- **Dev**: `gh` (GitHub CLI), `uv` (Python project manager)

### 🖥️ Tilix Terminal
Pre-configured with:
- Catppuccin Mocha color scheme
- Quake-style dropdown (`Ctrl+;`)
- Fish as default shell
- Slight transparency (5%) for that *aesthetic*

---

## Installation

### Step 0: Install Nix (The Gateway Drug)

This installer enables flakes by default and handles everything:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://artifacts.nixos.org/nix-installer | \
  sh -s -- install
```

Restart your terminal or run:
```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### Step 1: Clone This Bad Boy

```bash
git clone https://github.com/netlooker/bobs-nix-profile.git ~/.config/home-manager
cd ~/.config/home-manager
```

### Step 2: Configure Your Git Details

Edit `modules/shell.nix` and set your identity:

```nix
programs.git = {
  enable = true;
  settings = {
    user.name = "Your Name";
    user.email = "your.email@example.com";
    credential.helper = "store";
  };
};
```

### Step 3: Let Nix Do Its Thing

**First time (installs home-manager automatically):**
```bash
nix run home-manager/master -- switch --flake ~/.config/home-manager#default --impure
```

**After that, just use the alias:**
```bash
hm
```

The `--impure` flag is required because we auto-detect your username and home directory. Yes, it's slightly cursed. No, we don't care.

### Step 4: Restart Your Terminal

Log out and back in, or just restart your terminal. Welcome to the future.

---

## Making Changes

1. Edit the config files
2. Run `hm`
3. Profit

---

## Aliases Cheatsheet

| Alias | What it does |
|-------|--------------|
| `hm` | Rebuild home-manager config |
| `ll` | `eza -la` |
| `tree` | `eza --tree` |
| `pbcopy` | Copy to clipboard (macOS muscle memory friendly) |
| `pbpaste` | Paste from clipboard |

---

## Useful Commands

### Home Manager
```bash
home-manager build --flake ~/.config/home-manager  # Preview changes
nix flake update                                    # Update packages
home-manager news                                   # See what's new
home-manager generations                            # List generations
home-manager rollback                               # Undo mistakes
```

### JSON/YAML Wizardry
```bash
cat file.json | jq .                               # Pretty print JSON
aws ec2 describe-instances | jq '.Reservations[]'  # AWS + jq = 💪
cat config.yaml | yq -o json                       # YAML to JSON
```

### Modern CLI Tools
```bash
bat file.txt          # cat with syntax highlighting
rg "pattern"          # grep but fast
fd filename           # find but human
z project             # cd but smart (learns your habits)
```

---

## FAQ

**Q: Why Fish instead of Bash/Zsh?**  
A: Because autosuggestions and syntax highlighting out of the box. Also, we like to live dangerously.

**Q: Why `--impure`?**  
A: So the same flake works for any user without hardcoding usernames. It's a feature, not a bug.

**Q: Can I use this on macOS?**  
A: Theoretically yes, but you'll need to rip out the Tilix and dconf stuff. PRs welcome.

**Q: Why no Nerd Fonts?**  
A: Corporate environments and SSH sessions. Starship is configured with plain-text symbols that work everywhere.

---

## Troubleshooting

**Command not found after installation?**  
Log out and back in. Session variables need a fresh shell.

**Changes not taking effect?**  
Did you run `hm`? Run `hm`.

**Git keeps asking for credentials?**  
Enter them once. The credential helper stores them after first use.

---

## Resources

- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Package Search](https://search.nixos.org/packages)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)

---

## Contributing

Found a bug? Want to add your favorite tool? PRs welcome. Just remember:
- Keep it minimal
- Keep it reproducible  
- Keep it ✨ aesthetic ✨

## License

MIT - Do whatever you want, just don't blame us when you can't go back to vanilla terminals.

---

*"I used to have a dotfiles repo. Then I mass-adopted Nix and mass-adopted peace."* - Ancient Proverb
