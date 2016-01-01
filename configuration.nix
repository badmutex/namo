# -*- eval: (load-library "nix-mode"); mode: nix; -*-

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./samba.nix
    ];

  # boot.initrd.kernelModules = [ "zfs" ];
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "mandos" ];
  boot.zfs.forceImportAll = false;
  boot.zfs.forceImportRoot = false;

  # # stage 1 boot fails to find zfs pool
  # # see github.com/NixOS/nixpkgs/issues/11003
  # boot.kernelParams = [ ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.zfsSupport = true;
  boot.loader.grub.device = "/dev/disk/by-path/pci-0000:00:14.0-usb-0:2:1.0-scsi-0:0:0:0";

  networking = {
    hostId = "33025074";
    hostName = "namo";
    usePredictableInterfaceNames = true;
    firewall = {
      enable = false;
      # allowPing = true;
      # allowedTCPPorts = [
      #   139 445 # samba
      # ];
    };
    networkmanager.enable = false;
    tcpcrypt.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "US/Eastern";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    emacs24-nox
    nix-repl
    git
  ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  users.mutableUsers = false;
  users.users.root.passwordFile = "/etc/nixos/users/root/password";
  users.extraGroups.mandos.gid = 1002;
  users.extraUsers.badi = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "wheel" "mandos" ];
    passwordFile = "/etc/nixos/users/badi/password";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0AiBoBgua3YZTBfOgQk5JLdqzoY7e9ywRU3481mV2W9PRAJpkwTJ9l2vgfMt4Pj5xLJFzhwYRlZ607blXt/3pmxjfDHhsi00iXmxpkY3OLb0Fqpzeia0ibezO+7unHjb7/EhvQHX7ZBLGSsWQxDTwRhtTQF1SSrUqej1JJ+IfT6t7o+VZMIiPPswRa1pDCymI/gk9sW2RGDZr0CpTecgAEF+94Bfu6lckYLSJzIyqGzC650oqA21ubrmN7XkbgIY3jrCl13DAOArRsSlSsRMwsp8JbrJXShLnTDNxGNY/9FvEBDr3VDuDCa/lyTwdoyqn1Ev0wwy3EiQLSNdSEJ3dw== abdulwahidc@gmail.com"
    ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
