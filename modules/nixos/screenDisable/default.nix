# modules/networking.nix

{ config, ... }:

{
  systemd.services.disable-internal-backlight = {
    description = "Disable internal display backlight";
  
    wantedBy = [ "multi-user.target" ];
  
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  
    script = ''
      echo 0 > /sys/class/backlight/amdgpu_bl1/brightness
    '';
  };
}
