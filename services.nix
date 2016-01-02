# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  systemd.services."zfs-scrub@" = {
    description = "Scrub zfs pool %i";
    requires = [ "zfs.target" ];
    after = [ "zfs.target" ];
    serviceConfig = with pkgs; {
      Type = "oneshot";
      ExecStart = "${zfs}/bin/zpool scrub %i";
      ExecStop  = "${zfs}/bin/zpool scrub -s %i";
      RemainAfterExit = "true";
    };
  };

}
