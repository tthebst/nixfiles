{
  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
    utils.lib.eachDefaultSystem (system:
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
            bazelisk
            clang
            libclang
            libunwind
            cmake
            rustfmt
            pre-commit
            protobuf
            rustup
            rustPackages.clippy
            pkg-config
            openssl
            sqlite
            zlib
            gcc
            lld
          ];
          NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
            bazelisk
            clang
            libclang
            libunwind
            cmake
            rustfmt
            pre-commit
            protobuf
            rustup
            rustPackages.clippy
            pkg-config
            openssl
            sqlite
            zlib
            gcc
            lld
          ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          LIBCLANG_PATH = "${pkgs.llvmPackages_11.libclang.lib}/lib";
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";  
          NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
        };
      });
}
