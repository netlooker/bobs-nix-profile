{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal emulators
    tilix
    
    # TUI tools
    lazydocker
    mc
    
    # Modern CLI tools
    bat
    eza
    ripgrep
    fd
    tree
    
    # Network utilities
    curl
    wget
    
    # Archive utilities
    unzip
    zip
    
    # Development essentials
    tldr
    btop
    ncdu
    
    # Document conversion
    pandoc
    texlive.combined.scheme-small
    
    # Git tools
    gitingest
    
    # Data processing
    jq
    yq-go
    
    # Clipboard tools
    xclip
    
    # QR code tools
    qrencode
    
    # GTK fix
    libcanberra-gtk3
    
    # Node.js
    nodejs

    # Python ecosystem
    (python3.withPackages (ps: with ps; [
      pip
      python-pptx
      pandas
      pillow
      xlsxwriter
    ]))
    uv
  ];
}
