{
  description = "Dfx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "dfx-${version}";

        version = "0.12.0-beta.3";

        # https://nixos.wiki/wiki/Packaging/Binaries
        src = pkgs.fetchurl {
          url = "https://github.com/dfinity/sdk/releases/download/${version}/${name}-x86_64-linux.tar.gz";
          sha256 = "d0d85c09e83681c08e5babbb6fac04348af571165fc0ef7dfea775c5b9fa8720";
        };
        nativeBuildInputs = [
          autoPatchelfHook
        ];
        sourceRoot = ".";

        installPhase = ''
          install -m755 -D dfx $out/bin/dfx
          runHook postInstall
        '';
        postIntstall = ''
          $out/bin/dfx cache install 
          dfxcache = $out/bin/dfx cache show;
          autoPatchelf "$dfxcache/*"
        '';
        

      };
  };
}