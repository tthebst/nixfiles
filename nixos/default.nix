# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ../common
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  # Runnign into error because of this
  # https://discourse.nixos.org/t/how-to-disable-networkmanager-wait-online-service-in-the-configuration-file/19963
  systemd.services.NetworkManager-wait-online.enable = false;
  
  # Since we only use the machine via ssh we don't want to enter mergency mode.
  systemd.enableEmergencyMode = false;

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tim = {
    isNormalUser = true;
    description = "Tim Gretler";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; (import ../common/packages.nix { pkgs = pkgs; });

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  
  # enable the tailscale service
  services.tailscale.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = false;
  # Upnp
  services.gnome.rygel.enable = true;
  
  
  
    virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Ethereum development

  environment.etc."geth/jwttoken" = {
    # Used for development
    mode = "0444";
    text = "06e138d3abd00ba78a1b63cc7c936bf03b995624a169b0ead6bd80fa8919adab";
  };

  # Enablei goerli geth
  services.geth."goerli" = {
    enable = true;
    network = "goerli";
    extraArgs = [
      "--authrpc.port=8551"
      "--authrpc.jwtsecret=/etc/geth/jwttoken"
    ];
    http.enable = true;
    http.apis = [
      "net"
      "engine"
      "eth"
      "admin"
    ];
    metrics.enable = true;
  };

  # Mainnet.
  services.geth."mainnet" = {
    enable = true;
    # default 30303
    port = 30304;
    extraArgs = [
      "--authrpc.addr=0.0.0.0"
      "--authrpc.port=8552"
      "--authrpc.vhosts=*"
      "--authrpc.jwtsecret=/etc/geth/jwttoken"
    ];
    http.enable = true;
    # default 8545
    http.port = 8546;
    http.apis = [
      "net"
      "engine"
      "eth"
      "admin"
    ];
  };

  # Bitcoin node 
  services.bitcoind."btc" = {
    enable = true;
  };

  # Monero node 
  services.monero = {
    enable = true;
  };

  # Monero node 
  services.ipfs = {
    enable = true;
    enableGC = true;
    dataDir = "/mnt/ipfs";
  };
  
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
