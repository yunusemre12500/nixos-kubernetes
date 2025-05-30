{ ... }:
{
  # Caches DNS queries for faster lookups.
  services.resolved = {
    dnsovertls = "opportunistic"; # Use DNS over TLS (DoH) if available.
    dnssec = "true"; # Validate records.
    enable = true;
  };
}
