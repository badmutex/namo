{ config, pkgs, ... }:

let
  inherit (builtins) readFile toFile replaceStrings;

  pia-files = pkgs.fetchzip {
    url = "https://www.privateinternetaccess.com/openvpn/openvpn.zip";
    stripRoot = false;
    sha256 = "0am5ylgwrly1747xldcfv80pzpbf0ypa5djqdbjnn4qfnsywxw6n";
  };

  cert =
    toFile "pia_ca.crt"
    (readFile "${pia-files}/ca.crt");

  pem =
    toFile "pia_crl.pem"
    (readFile "${pia-files}/crl.pem");

  pia = { server ? "us-midwest.privateinternetaccess.com" }:
  ''
    client
    dev tun
    proto udp
    remote ${server} 1194
    resolv-retry infinite
    nobind
    persist-key
    persist-tun
    ca ${cert}
    tls-client
    remote-cert-tls server
    auth-user-pass /root/.pia/auth
    comp-lzo
    verb 1
    reneg-sec 0
    crl-verify ${pem}
  '';

in

{ services.openvpn.servers.pia.config = pia {}; }
