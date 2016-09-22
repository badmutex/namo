# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ ... }:

{
  services.syncthing = {
    enable = true;
    useInotify = true;
  };
  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 21027 ];
}
