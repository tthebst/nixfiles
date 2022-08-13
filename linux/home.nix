{ config, pkgs, ... }:

let
  common-programs = import ../common/home-manager.nix { pkgs = pkgs; mail="tim.gretler@dfinity.org"; }; 
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
    
  nixpkgs.config.allowUnfree = true;    
  home.enableNixpkgsReleaseCheck = false;
  home.packages = pkgs.callPackage ./packages.nix {};
  programs = common-programs;

}
