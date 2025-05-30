{ ... }:
{
  boot = {
    crashDump.enable = true; # Enabled for debugging and emergency purposes.
    enableContainers = false; # You don't need NixOS containers on Kubernetes.
    initrd = {
      network.enable = true;
      systemd = {
        enable = true;
        network = {
          enable = true;
          wait-online.enable = false; # Typiclly servers use static IP addresses and wait-online service is useless.
        };
      };
    };
    loader = {
      # This system uses systemd-boot and UEFI.
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 5;
        editor = false;
        enable = true;
      };
    };
    tmp = {
      cleanOnBoot = true; # Clean up /tmp when system boots.
      useTmpfs = false; # Not required. Maybe enable?
    };
  };
}
