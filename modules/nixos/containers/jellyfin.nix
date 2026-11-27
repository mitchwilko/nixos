{ config, pkgs, lib, ... }:

{
  containers.jellyfin = {
    autoStart = true;

    privateNetwork = true;

    # Same host bridge range as the gateway container (.4).
    # Pick any free address in 192.168.100.0/24.
    hostAddress = "192.168.100.1";
    localAddress = "192.168.100.6";

    # No forwardPorts required.
    #
    # Jellyfin is only reachable over the tailnet at:
    #   http://jellyfin.bream-betta.ts.net:8096

    bindMounts = {
      # Media library (read-only inside the container).
      "/media" = {
        hostPath = "/srv/media";
        isReadOnly = true;
      };

      # Optional: keep Jellyfin state on a host path you back up.
      # Without this it still persists under
      # /var/lib/nixos-containers/jellyfin/var/lib/jellyfin
      # "/var/lib/jellyfin" = {
      #   hostPath = "/srv/jellyfin/state";
      #   isReadOnly = false;
      # };

      # Optional: hardware transcoding (Intel/AMD VAAPI / QSV).
      # Also uncomment the /dev/dri entries in allowedDevices.
      # "/dev/dri" = {
      #   hostPath = "/dev/dri";
      #   isReadOnly = false;
      # };
    };

    allowedDevices = [
      {
        node = "/dev/net/tun";
        modifier = "rw";
      }

      # Hardware transcoding:
      # { node = "/dev/dri/renderD128"; modifier = "rw"; }
      # { node = "/dev/dri/card0";      modifier = "rw"; }
    ];

    config = { config, pkgs, lib, ... }: {

      # ------------------------------------------------------------
      # Tailscale
      # ------------------------------------------------------------

      services.tailscale.enable = true;

      systemd.services.tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];

      # ------------------------------------------------------------
      # Jellyfin
      #
      # Web UI / API on port 8096. The firewall is NOT opened for it
      # directly; it is reachable via the trusted tailscale interface.
      # ------------------------------------------------------------

      services.jellyfin = {
        enable = true;
        openFirewall = false;
      };

      # Hardware transcoding: let the jellyfin user use the GPU.
      # users.users.jellyfin.extraGroups = [ "video" "render" ];
      # hardware.graphics = {
      #   enable = true;
      #   extraPackages = with pkgs; [
      #     intel-media-driver   # Intel Broadwell+ (iHD)
      #     # vpl-gpu-rt         # Intel QSV on 11th gen+
      #   ];
      # };

      environment.systemPackages = [
        pkgs.jellyfin
        pkgs.jellyfin-web
        pkgs.jellyfin-ffmpeg
      ];

      # ------------------------------------------------------------
      # Networking
      # ------------------------------------------------------------

      networking.nftables.enable = true;

      networking.firewall = {
        enable = true;

        # Nothing exposed on the container's veth interface.
        allowedTCPPorts = [ ];

        # Tailscale.
        allowedUDPPorts = [
          config.services.tailscale.port
        ];

        # Everything (incl. Jellyfin on 8096) is allowed over the tailnet.
        trustedInterfaces = [
          config.services.tailscale.interfaceName
        ];
      };

      networking.nameservers = [
        "1.1.1.1"
        "9.9.9.9"
      ];

      networking.useHostResolvConf = lib.mkForce false;

      system.stateVersion = "26.05";
    };
  };
}
