{ ... }:
{
  # This configuration simply creates EFI partition with 512MB space then creates a root partition with remaining space.
  disko.devices.disk.main = {
    content = {
      partitions = {
        efi = {
          content = {
            format = "vfat";
            mountOptions = [ "umask=0077" ];
            mountpoint = "/boot";
            type = "filesystem";
          };
          size = "512M";
          type = "EF00";
        };
        root = {
          content = {
            format = "xfs"; # If you prefer another filesystem, change this line.
            mountpoint = "/";
            type = "filesystem";
          };
          size = "100%";
        };
      };
      type = "gpt";
    };
    device = "/dev/sda"; # /dev/sda not same in all systems run lsblk before installation and change this line based on output.
    type = "disk";
  };
}
