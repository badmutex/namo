# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, lib, pkgs, ... }:

{

  # make sure to also add the *samba* user:
  # $ smbpasswd -a badi

  services.samba = {
    enable = true;
    shares = {
      mandos = {
        path = "/mandos";
	"valid users" = "@mandos";
	writable = "yes";
	browsable = "yes";
	"inherit owner" = "yes";
	"inherit permissions" = "yes";
	"inherit acls" = "yes";
	"guest ok" = "no";
	"read only" = "no";
	"force user" = "badi";
	"force group" = "mandos";
      };
    };
    extraConfig = ''
      guest account = nobody
      # map to guest = bad user
      bind interfaces only = yes
      interfaces = eno1 127.0.0.1
      encrypt passwords = yes
      printcap name = /dev/null
      load printers = no
      # check password script
      # passwd program
      # unix password sync
    '';
  };

  # for some reason samba is not really active on initial boot.
  # this adds a timer to start samba again after a few seconds.
  systemd.services.samba-restart = {
    after = ["network-online.target"];
    serviceConfig = with pkgs; {
      Type = "oneshot";
      ExecStart = "${systemd}/bin/systemctl restart samba.target";
    };
  };

  systemd.timers.samba-start = {
    wantedBy = [ "multi-user.target" ];
    after = [ "samba.target" "timer-sync.target" ];
    timerConfig = {
      Unit = "samba-restart.service";
      OnBootSec = "60";
    };
  };

}
