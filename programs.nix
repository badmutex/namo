# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    file
    wget
    aria
    emacs24-nox
    nix-repl
    git
    smartmontools
    hdparm
    sdparm
    lsscsi
    pciutils
  ];

}
