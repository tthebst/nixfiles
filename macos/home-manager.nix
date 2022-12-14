{ config, pkgs, lib, ... }:

let
  common-programs = import ../common/home-manager.nix { pkgs = pkgs; mail = "gretler.tim@gmail.com"; }; 
in
{
  imports = [
    <home-manager/nix-darwin>
  ];

  # It me
  users.users.timprivate = {
    name = "timprivate";
    home = "/Users/timprivate";
    shell = pkgs.fish;
    isHidden = false;
  };
  users.users.timgretler = {
    name = "timgretler";
    home = "/Users/timgretler";
    shell = pkgs.fish;
    isHidden = false;
  };

  home-manager = {
    useGlobalPkgs = true;
    users.timprivate = { pkgs, lib, ... }: {
      home.enableNixpkgsReleaseCheck = false;
      home.packages = pkgs.callPackage ./packages.nix {};
      programs = common-programs;
      home.stateVersion = "22.05";
    };
    users.timgretler= { pkgs, lib, ... }: {
      home.enableNixpkgsReleaseCheck = false;
      home.packages = pkgs.callPackage ./packages.nix {};
      programs = common-programs;
      home.stateVersion = "22.05";
    };
  };
}
