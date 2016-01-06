{pkgs, ...}:

let
    smartctlHelper = with pkgs; writeScript "smartctlServiceHelper" ''
      #!${bash}/bin/bash

      set -e
      set -x

      usage() {
        echo "$0 start|stop"
      }

      list-disks() {
        ${smartmontools}/bin/smartctl --scan | cut -d' ' -f1
      }

      smartService() {
        local action=$1
        local disk=$2
        ${systemd}/bin/systemctl $action smartctl-short-test@$disk.service
      }

      do-action() {
        local action=$1
        list-disks \
          | while read disk; do
              smartService $action $disk
            done
      }

      case $1 in
        start) do-action start;;
        stop)  do-action stop;;
        *)
          echo "Unknown action $1";
          usage
          exit 1
          ;;
        esac
      '';

in

{

  services.smartd = {
    enable = true;
  };


  # systemd.services."smartctl-short-test@" = {
  #   description = "Run a short SMART test on %I";
  #   requires = [ "local-fs.target" ];
  #   serviceConfig = with pkgs; {
  #     Type = "oneshot";
  #     ExecStart = "${smartmontools}/bin/smartctl -t short %I";
  #     ExecStop  = "${smartmontools}/bin/smartctl -X %I";
  #     RemainAfterExit = "true";
  #   };
  # };

  # systemd.services.smartctl-scan-short-all = {
  #   description = "Run a short test on all detected disks";
  #   requires = [ "local-fs.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${smartctlHelper} start";
  #     ExecStop  = "${smartctlHelper} stop";
  #     Remainafterexit = "true";
  #   };
  # };

  # systemd.timers.smartctl-scan-short-all = {
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "local-fs.target" ];
  #   timerConfig = {
  #     Unit = "smartctl-scan-short-all.service";
  #     OnCalendar = "Tue-Sun 04:00";
  #   };
  # };

}
