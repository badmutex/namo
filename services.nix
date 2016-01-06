# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  imports = [
    ./services/smart.nix
  ];

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

  systemd.timers."zfs-scrub-mandos" = {
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];
    timerConfig = {
      Unit = "zfs-scrub@mandos.service";
      OnCalendar = "Sun 23:00";
      Persistent = "true";
    };
  };

}
