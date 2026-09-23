# modules/lamco.nix

{ config, pkgs, lib, ... }:

let
  lamco-rdp-server = pkgs.callPackage ../../.././pkgs/lamco-rdp/package.nix {};
in
{
  environment.systemPackages = [
    lamco-rdp-server
  ];

  environment.etc."lamco-rdp-server/config.toml".text = ''
    [server]
    listen_addr = "[::]:3389"
    max_connections = 4
    session_timeout = 0
    use_portals = false

    # [security]
    # cert_path = "/etc/lamco-rdp-server/cert.pem"
    # key_path = "/etc/lamco-rdp-server/key.pem"

    # enable_nla = true
    # auth_method = "pam"

    [video]
    target_fps = 30
    cursor_mode = "metadata"

    [input]
    input_protocol = "auto"
    keyboard_layout = "auto"
    enable_touch = false

    [clipboard]
    enabled = true
    protocol = "auto"
    allow_fallback = true

    [multimon]
    enabled = true
    max_monitors = 4

    [performance]
    encoder_threads = 0
    network_threads = 0
    buffer_pool_size = 16
    zero_copy = true

    [performance.adaptive_fps]
    enabled = true
    min_fps = 5
    max_fps = 30

    [performance.latency]
    mode = "interactive"

    [egfx]
    enabled = true
    codec = "auto"
    avc444_enabled = true

    [damage_tracking]
    enabled = true
    method = "diff"

    [hardware_encoding]
    enabled = true
    vaapi_device = "/dev/dri/renderD128"
    enable_dmabuf_zerocopy = true
    fallback_to_software = true
    quality_preset = "balanced"
  '';

  # The certificate/key should NOT be generated in the Nix store.
  systemd.tmpfiles.rules = [
    "d /etc/lamco-rdp-server 0755 root root -"
  ];
}
