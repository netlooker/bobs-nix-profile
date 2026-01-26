{ pkgs, config, ... }:

{
  # FIX: Tell npm exactly where to install packages using the absolute path.
  # This creates a ~/.npmrc file automatically.
  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm-global
  '';

  # Add npm global bin to PATH for ALL shells (interactive and non-interactive)
  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
  ];

  programs.fish = {
    enable = true;
    plugins = [
    ];
    interactiveShellInit = ''
      eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
      set fish_greeting
      # Rebind fzf file search from Ctrl+T to Ctrl+F (Ctrl+T is Tilix new tab)
      bind \cf fzf-file-widget
      bind -e \ct
    '';
    shellAliases = {
      # Home Manager
      hm = "home-manager switch --flake ~/.config/home-manager#default --impure";
      
      # Clipboard (macOS-style)
      pbcopy = "xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard -o";
      
      # Use modern tools by default
      cat = "bat";
      ls = "eza";
      ll = "eza -la";
      tree = "eza --tree";
    };
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "netlooker";
      user.email = "netlooker@outlook.be";
      credential.helper = "store";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs.lazygit.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      format = "$all";
      character = { success_symbol = ">"; error_symbol = "[x](bold red)"; };
      git_commit.tag_symbol = " tag ";
      git_status = { ahead = ">"; behind = "<"; diverged = "<>"; renamed = "r"; deleted = "x"; };
      directory.read_only = " ro";
      
      # Plain-text symbols (no nerd fonts needed)
      aws.symbol = "aws ";
      bun.symbol = "bun ";
      c.symbol = "C ";
      cmake.symbol = "cmake ";
      conda.symbol = "conda ";
      dart.symbol = "dart ";
      deno.symbol = "deno ";
      docker_context.symbol = "docker ";
      dotnet.symbol = ".NET ";
      elixir.symbol = "exs ";
      elm.symbol = "elm ";
      gcloud.symbol = "gcp ";
      git_branch.symbol = "git ";
      golang.symbol = "go ";
      java.symbol = "java ";
      kotlin.symbol = "kt ";
      lua.symbol = "lua ";
      nodejs.symbol = "nodejs ";
      nix_shell.symbol = "nix ";
      package.symbol = "pkg ";
      python.symbol = "py ";
      ruby.symbol = "rb ";
      rust.symbol = "rs ";
      terraform.symbol = "terraform ";
    };
  };
}
