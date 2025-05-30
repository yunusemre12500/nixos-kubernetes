{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/shared
  ];

  networking.hostName = "control-plane";

  services.openssh.banner = "This server runs Kubernetes Control Plane. Unauthorized access not allowed.";

  system.stateVersion = "25.05";
}
