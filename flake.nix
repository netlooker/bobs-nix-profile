{
  description = "Bob's Nix AWS Config - Team-ready Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }: 
    let
      system = builtins.currentSystem;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # Auto-detect username and home directory (requires --impure flag)
      username = builtins.getEnv "USER";
      homeDirectory = builtins.getEnv "HOME";
      
      # Validate that we have the required environment variables
      validatedUsername = 
        if username == "" 
        then throw "Unable to detect username. Please run with: home-manager switch --flake .#default --impure"
        else username;
      
      validatedHomeDirectory = 
        if homeDirectory == "" 
        then throw "Unable to detect home directory. Please run with: home-manager switch --flake .#default --impure"
        else homeDirectory;
    in {
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix 
          catppuccin.homeModules.catppuccin
          {
            home.username = validatedUsername;
            home.homeDirectory = validatedHomeDirectory;
          }
        ];
      };
    };
}

