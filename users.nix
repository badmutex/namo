# -*- eval: (load-library "nix-mode"); mode: nix; -*-

{ config, pkgs, ... }:

{

  users.mutableUsers = true;
  users.extraGroups.mandos.gid = 1002;
  users.extraUsers.badi = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "wheel" "mandos" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0AiBoBgua3YZTBfOgQk5JLdqzoY7e9ywRU3481mV2W9PRAJpkwTJ9l2vgfMt4Pj5xLJFzhwYRlZ607blXt/3pmxjfDHhsi00iXmxpkY3OLb0Fqpzeia0ibezO+7unHjb7/EhvQHX7ZBLGSsWQxDTwRhtTQF1SSrUqej1JJ+IfT6t7o+VZMIiPPswRa1pDCymI/gk9sW2RGDZr0CpTecgAEF+94Bfu6lckYLSJzIyqGzC650oqA21ubrmN7XkbgIY3jrCl13DAOArRsSlSsRMwsp8JbrJXShLnTDNxGNY/9FvEBDr3VDuDCa/lyTwdoyqn1Ev0wwy3EiQLSNdSEJ3dw== abdulwahidc@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXOgmmh7lzXpVokYnuNuUM2TRQDliQDAzEjeGlR/88z580ktTfqFj+BLlRULc52OUaq5/wLL9fVQqQHdWv0FslgSwW9wrqKuYo3ZyazP7Qz41daqiaEH2pVLTCfiqD2qVYwbVJHPcYwY3VBLSi5HwzlcZrM+jQR1lbLUpLm0w02brFVJr393q7p6prWjcRsiItI2Nimbx7rj4uLUMydQTXTiW92QiQ3eKOIX1Zb+8hx0AMdB9jCevdVojUbQ3wTdGN0Swf2371jSzS1PqGwH0nFi1QmwPj0OFlYU/OeXMOR/usHz5v8bFjPwpL3opC2eIfnTxR84hXE1hjWraxK2C1 host:irmo contact:badi@iu.edu"
    ];
  };

}
