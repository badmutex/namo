# -*- eval: (load-library "nix-mode"); mode: nix; -*-
{ config, pkgs, ... }:

{

  # networking.nat.enable = true;
  # networking.nat.internalInterfaces = ["ve-+"];
  # networking.nat.externalInterface = "enp6s0";

  networking.bridges.br0.interfaces = [ "enp6s0" ];

  containers.vpn = {
    # privateNetwork = true;
    # hostAddress = "10.0.1.1";
    # localAddress = "10.0.1.10";
    interfaces = ["enp6s0"];
    config = {config, pkgs, ...}: {
      # services.openvpn.enable = true;
    };
  };

}
