{ config, pkgs, ... }:
{
  imports = [
    ../services/kubelet.nix
    ../services/resolved.nix
    ../services/openssh.nix
    ./boot-loader.nix
    ./disk-layout.nix
    ./networking.nix
  ];

  environment.systemPackages = with pkgs; [
    containerd
    cni-plugins
    cri-tools
    gvisor
    kubernetes
  ];

  powerManagement.cpuFreqGovernor = "performance";

  security = {
    protectKernelImage = true;
    sudo.enable = false;
    sudo-rs.enable = true;
  };

  time.timeZone = "UTC";

  users = {
    groups.kubernetes = { };
    mutableUsers = false;
    users = {
      kubernetes = {
        description = "Kubernetes";
        extraGroups = [ "wheel" ];
        group = "kubernetes";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          # Change with your own SSH public key(s).
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINI0aRhd7IrbYmSddVvItCfTxWmhvEt4u/LjtefKcgri"
        ];
      };
      root = {
        openssh.authorizedKeys.keys = config.users.users.kubernetes.openssh.authorizedKeys.keys;
        shell = "/sbin/nologin";
      };
    };
  };
}
