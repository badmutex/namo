# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
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
    tmux
    gptfdisk
    unzip
    unrar
  ];

}
