{ ... }:
{
  # Runs SSH server during initrd stage. Used for emergency purposes.
  boot.initrd.network.ssh = {
    enable = true;
    hostKeys = [ /etc/ssh/authorized_keys ];
  };
  services.openssh = {
    allowSFTP = false; # Enable if you are using.
    enable = true;
    settings = {
      # Some hardening steps.
      AllowUsers = [ "kubernetes" ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      PrintMotd = true;
      UsePAM = false;
    };
    # Stop SSH server if no connection established.
    startWhenNeeded = true;
  };
}
