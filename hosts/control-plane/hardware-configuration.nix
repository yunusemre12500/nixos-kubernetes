{ lib, ... }:
{
  networking.firewall.interfaces.eno1.allowedTCPPorts = lib.mkAfter [
    6443 # Kubernetes API Server
  ];
}
