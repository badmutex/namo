# -*- eval: (load-library "nix-mode"); mode: nix; -*-

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
      ./boot.nix
      ./networking.nix
      ./samba.nix
      ./programs.nix
      ./services.nix
      ./users.nix

      # ./containers.nix
    ];

  hardware.cpu.intel.updateMicrocode = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "US/Eastern";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
