{
  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    language-servers.url = git+https://git.sr.ht/~bwolf/language-servers.nix;
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, language-servers, utils, naersk }:
    utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk { };
      in
      {
        defaultPackage = naersk-lib.buildPackage ./.;

        defaultApp = utils.lib.mkApp {
          drv = self.defaultPackage."${system}";
        };

        devShell = with pkgs; mkShell {
          buildInputs = [ 
            clang 
            libclang 
            cmake 
            rustfmt 
            pre-commit 
            protobuf 
            libunwind
            rustup 
            rustPackages.clippy 
            pkg-config 
            openssl
            jdk
            nodejs
            nodePackages.ganache
            nodePackages.typescript-language-server
            nodePackages.bash-language-server
            nodePackages.typescript
            nodePackages.svelte-language-server
            nodePackages.rollup
            # vscode-{css,eslint,html,json}-language-server 
            language-servers.packages.${system}.vscode-langservers-extracted
            ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig"; 
          CURL_CA_BUNDLE="/etc/ssl/certs/ca-bundle.crt";
          # shellHook = ''
            # export PATH=~/.cargo/bin:$PATH
          # '';
        };
      });
}
