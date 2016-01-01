# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{
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

}
