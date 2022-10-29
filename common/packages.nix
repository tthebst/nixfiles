{ pkgs }:

with pkgs; [
  bash
  ledger
  duf
  du-dust
  fish
  nerdfonts
  glances
  neofetch
  jwt-cli
  home-manager
  htop
  openssh
  python3
  ripgrep
  rnix-lsp
  rust-analyzer
  unrar
  unzip
  vim
  wget
  zip
  inetutils
  pprof
  nodePackages.typescript-language-server
  nodePackages.bash-language-server
  nodePackages.typescript
  nodePackages.svelte-language-server
  nodePackages.rollup
]
