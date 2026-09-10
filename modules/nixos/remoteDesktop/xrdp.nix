# module/xrdp

{ pkgs, ... }: 

{
  services.xrdp = {
    enable = true;
    openFirewall = true;
    # defaultWindowManager = "${pkgs.xfce4-14.xfce4-session}/bin/xfce4-session";
    defaultWindowManager = "${pkgs.i3}/bin/i3"; # or "gnome-session"
  };

  networking.firewall.allowedTCPPorts = [ 3389 ];
}
