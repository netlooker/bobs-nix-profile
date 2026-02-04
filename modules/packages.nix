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
    just
    
    # Document conversion
    pandoc
    texlive.combined.scheme-small
    
    # Git tools
    gitingest
    gh
    
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

    # Browser
    chromium

    # Media tools
    yt-dlp
    ffmpeg

    # Python ecosystem
    (python3.withPackages (ps: with ps; [
      pip
      python-pptx
      pandas
      pillow
      xlsxwriter
      ml-dtypes
      scipy
      numpy
    ]))
    uv

    # SQLite Extensions
    sqlite-vec
    
    # Networking
    tailscale
  ];
}
