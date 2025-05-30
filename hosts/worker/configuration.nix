{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/shared
  ];

  networking.hostName = "worker";

  services.openssh.banner = "This server is part of a Kubernetes Cluster. Unauthorized access not allowed.";

  system.stateVersion = "25.05";
}
