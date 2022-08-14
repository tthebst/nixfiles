{ pkgs, ... }:

let
  common-programs = import ../common/home-manager.nix { pkgs = pkgs; mail="gretler.tim@gmail.com"; }; in
{
  home = {
    enableNixpkgsReleaseCheck = false;
    packages = pkgs.callPackage ./packages.nix {};
    username = "tim";
    homeDirectory = "/home/tim";
    stateVersion = "22.05";
  };

  # TODO: Clean this up. Import these so we use Nix composability.
  programs = common-programs;
}
