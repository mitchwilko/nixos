# modules/lamco.nix

{ config, pkgs, lib, ... }:

let
  lamco-rdp-server = pkgs.callPackage ../../.././pkgs/lamco-rdp-server/package.nix {};
in
{
  environment.systemPackages = [
    lamco-rdp-server
  ];

  environment.etc."lamco-rdp-server/config.toml".text = ''
    config_version = 1
    
    [server]
    listen_addr = "[::]:3389"
    max_connections = 4
    session_timeout = 0
    use_portals = false
    view_only = false
    
    [server.transports]
    
    [security]
    cert_path = "/home/mitchw/.config/lamco-rdp-server/cert.pem"
    key_path = "/home/mitchw/.config/lamco-rdp-server/key.pem"
    enable_nla = false
    security_mode = "auto"
    auth_method = "none"
    require_tls_13 = false
    
    [video]
    target_fps = 30
    cursor_mode = "metadata"
    
    [video_pipeline.processor]
    target_fps = 30
    max_queue_depth = 30
    adaptive_quality = true
    damage_threshold = 0.05
    drop_on_full_queue = true
    enable_metrics = true
    
    [video_pipeline.dispatcher]
    channel_size = 30
    priority_dispatch = true
    max_frame_age_ms = 150
    enable_backpressure = true
    high_water_mark = 0.8
    low_water_mark = 0.5
    load_balancing = true
    
    [video_pipeline.converter]
    buffer_pool_size = 8
    enable_simd = true
    damage_threshold = 0.75
    enable_statistics = true
    
    [capture]
    protocol = "wlr"
    allow_fallback = true
    handshake_timeout_ms = 5000
    gnome_record_mode = "auto"
    gnome_virtual_is_platform = false
    
    [input]
    input_protocol = "auto"
    keyboard_layout = "auto"
    enable_touch = false
    
    [clipboard]
    enabled = true
    max_size = 10485760
    rate_limit_ms = 200
    allowed_types = []
    protocol = "auto"
    allow_fallback = true
    kde_syncselection_hint = false
    
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
    high_activity_threshold = 0.3
    medium_activity_threshold = 0.1
    low_activity_threshold = 0.01
    
    [performance.latency]
    mode = "balanced"
    interactive_max_delay_ms = 16
    balanced_max_delay_ms = 33
    quality_max_delay_ms = 100
    balanced_damage_threshold = 0.02
    quality_damage_threshold = 0.05
    
    [logging]
    level = "info"
    metrics = true
    
    [egfx]
    enabled = true
    h264_level = "auto"
    h264_bitrate = 5000
    zgfx_compression = "never"
    max_frames_in_flight = 3
    frame_ack_timeout = 5000
    periodic_idr_interval = 5
    codec = "auto"
    qp_min = 10
    qp_max = 40
    qp_default = 23
    avc444_aux_bitrate_ratio = 0.5
    color_matrix = "auto"
    color_range = "auto"
    avc444_enabled = true
    avc444_enable_aux_omission = true
    avc444_max_aux_interval = 30
    avc444_aux_change_threshold = 0.05
    avc444_force_aux_idr_on_return = false
    
    [egfx.encoding_adaptation]
    enabled = false
    base_qp = 22
    min_qp = 18
    max_qp = 42
    evaluation_interval_ms = 500
    moderate_queue_threshold = 3
    severe_queue_threshold = 6
    
    [damage_tracking]
    enabled = true
    method = "diff"
    tile_size = 16
    diff_threshold = 0.01
    pixel_threshold = 1
    merge_distance = 16
    min_region_area = 64
    compositor_hint_distrust_threshold_pp = 15.0
    compositor_hint_distrust_consecutive_samples = 3
    
    [hardware_encoding]
    enabled = false
    vaapi_device = "/dev/dri/renderD128"
    enable_dmabuf_zerocopy = true
    fallback_to_software = true
    quality_preset = "balanced"
    prefer_nvenc = true
    backend_priority = [
        "vulkan-video",
        "nvenc",
        "vaapi",
    ]
    vulkan_device = "auto"
    
    [display]
    allow_resize = true
    allowed_resolutions = []
    dpi_aware = false
    frame_transform = "auto"
    color_management = true
    output_management = true
    resize_drives_output_mode = true
    hdr_tone_mapping = false
    
    [advanced_video]
    enable_frame_skip = true
    scene_change_threshold = 0.7
    intra_refresh_interval = 300
    enable_adaptive_quality = false
    
    [cursor]
    mode = "metadata"
    auto_mode = true
    predictive_latency_threshold_ms = 100
    cursor_update_fps = 60
    
    [cursor.predictor]
    history_size = 8
    lookahead_ms = 50.0
    velocity_smoothing = 0.4
    acceleration_smoothing = 0.2
    max_prediction_distance = 100
    min_velocity_threshold = 50.0
    stop_convergence_rate = 0.5
    
    [audio]
    enabled = true
    codec = "auto"
    sample_rate = 48000
    channels = 2
    frame_ms = 20
    opus_bitrate = 64000
    
    [notifications]
    on_error = true
    on_cert_expiry = true
    
    [monitoring]
    enabled = true
    snapshot_interval_secs = 5
    metrics_bind = "127.0.0.1:9100"
    
    [gui_state]
    expert_mode = false
    egfx_expert_mode = false
    video_pipeline_expanded = false
    adaptive_fps_expanded = true
    latency_expanded = true
    damage_tracking_expanded = true
    hardware_encoding_expanded = true
    display_expanded = true
    advanced_video_expanded = false
    cursor_expanded = true
    cursor_predictor_expanded = false
    multimon_expanded = false
    logging_expanded = false
    log_auto_scroll = true
    log_filter_level = "info"
    close_stops_server = true
    
    [diagnostics]
    decode_self_test = false
  '';

  # The certificate/key should NOT be generated in the Nix store.
  systemd.tmpfiles.rules = [
    "d /etc/lamco-rdp-server 0755 root root -"
  ];
}
