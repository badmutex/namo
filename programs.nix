# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    wget
    emacs24-nox
    nix-repl
    git
  ];

}
