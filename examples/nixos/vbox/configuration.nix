{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    [ <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
      <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
      <nixpkgs/nixos/modules/profiles/demo.nix>
      <nixpkgs/nixos/modules/profiles/clone-config.nix>
    ];

  # FIXME: UUID detection is currently broken
  boot.loader.grub.fsIdentifier = "provided";

  # Allow mounting of shared folders.
  users.extraUsers.demo.extraGroups = [ "vboxsf" ];

  environment.systemPackages = with pkgs; [ vim 
                                            git
                                            lynx
                                            tree
                                            htop
                                            gdal ];
  # For german keyboard and umlauts
  i18n = {
    consoleKeyMap = "de-latin1-nodeadkeys";
    defaultLocale = "de_DE.UTF-8";
  };
  
  # Gitlab-Configuration: 
  
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."git.example.at" = {
      # enableACME = true;
      # forceSSL = true;
      # locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
    };
  };


  #services.gitlab.enable = true;
  ## (TODO: Passwords!)
  #services.gitlab.databasePassword = "password";
  #services.gitlab.secrets.secret = "30charrandomstuff";
  #services.gitlab.secrets.otp = "30charrandomstuff";
  #services.gitlab.secrets.db = "30charrandomstuff";
  #systemd.services.gitlab.serviceConfig.TimeoutStartSec = "10min";  

  # Add some more video drivers to give X11 a shot at working in
  # VMware and QEMU.
  services.xserver.videoDrivers = mkOverride 40 [ "virtualbox" "vmware" "cirrus" "vesa" ];

  # SVN-Server:
  services.httpd.enable = true;
  services.httpd.adminAddr = "noone@example.at";
  services.httpd.subservices = {
    subversion = {
      enable = true;
      dataDir = "/var/subversion";
      notificationSender = "asdf@example.at";
    };
  };


}
