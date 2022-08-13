{ config, pkgs, nixpkgs, ... }:
{

  imports = [
    ../common
    ./home-manager.nix
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  services.activate-system.enable = true;

  # Setup user, packages, programs
  nix = {
    trustedUsers = [ "@admin" "timgretler" ];
    package = pkgs.nixUnstable;
    gc.user = "root";
    # Highly recommend adding these to save keystrokes
    # at the command line
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  environment.systemPackages = with pkgs; (import ../common/packages.nix { pkgs = pkgs; });

#  system.stateVersion = 4;

  environment.shells = with pkgs; [ fish zsh ];
  

  programs = {
    fish.enable = true;
  };
}
