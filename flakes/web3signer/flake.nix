{
  description = "Consenys Web3signer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "web3signer-${version}";

        version = "22.8.1";

        # https://nixos.wiki/wiki/Packaging/Binaries
        src = pkgs.fetchurl {
          url = "https://github.com/ConsenSys/web3signer/archive/refs/tags/${version}.tar.gz";
          sha256 = "c888222484c4d1b6203bd6d248890adf713f8bf47fb362fb36e8d47a98cb401";
        };

        sourceRoot = ".";
				
				buildInputs = [
					jdk-11
				];

        installPhase = ''
				
	
				$out/gradlew build
				tar -xzf $out/buuild/distribution/web3signer-${version}.tar.gz
        install -m755 -D web3signer $out/buuild/distribution/web3signer-${version}/bin/web3signer
        '';

        meta = with lib; {
          homepage = "https://docs.web3signer.consensys.net/";
          description = "Web3signer";
          platforms = platforms.linux;
        };
      };
  };
}
