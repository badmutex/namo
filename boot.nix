# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  imports = [
     ./hardware-configuration.nix
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

}
