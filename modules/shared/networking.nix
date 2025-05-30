{ config, lib, ... }:
{
  networking = {
    dhcpcd.enable = false; # Disabled for stability.
    domain = "internal"; # For easy discovery for nodes using LLMNR protocol.
    enableIPv6 = false; # IPv6 is not widely adopted and not completly stable.
    firewall = {
      logRefusedConnections = false;
      interfaces.eno1 = {
        allowedTCPPorts = [
          22 # You know, SSH.
          6081 # GENEVE, for cilium CNI's Overlay network.
          10250 # Kubelet node agent.
        ];
        allowedTCPPortRanges = [
          # For NodePort services to work.
          {
            from = 30000;
            to = 32767;
          }
        ];
        allowedUDPPortRanges = [
          # Same as (but for UDP) allowedTCPPortRanges.
          {
            from = 30000;
            to = 32767;
          }
        ];
      };
    };
    interfaces.eno1.mtu = 9000; # If your network devices (firewalls, switches, routers, etc.) does not support Jumbo Frames (MTU > 1500) disable it.
    nameservers =
      [
        "1.1.1.2"
        "1.0.0.2"
      ]
      ++ lib.optionals config.networking.enableIPv6 [
        "2606:4700:4700::1112"
        "2606:4700:4700::1002"
      ];
    resolvconf.useLocalResolver = true; # Use DNS cache to prevent slow queries.
    useDHCP = false; # Disabled for stability.
    useNetworkd = true;
  };

  boot.kernel.sysctl =
    {
      "net.ipv4.ip_forward" = 1; # Needed for CNI to work.
    }
    // lib.optionalAttrs (!config.networking.enableIPv6) {
      # This sysctl options disables IPv6 at kernel level when enableIPv6 is set to false.
      "net.ipv6.conf.all.disable_ipv6" = 1;
      "net.ipv6.conf.default.disable_ipv6" = 1;
      "net.ipv6.conf.lo.disable_ipv6" = 1;
    };
}
