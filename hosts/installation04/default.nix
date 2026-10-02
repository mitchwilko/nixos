# Config file for Roland (Rasp Pi)
# Currently set up for temp virtualisation

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware.nix
      ../../modules/common
      ../../modules/nixos
      ../../modules/nixos/networking/nat.nix
      ../../modules/nixos/containers/dns.nix
      ../../modules/nixos/containers/proxy.nix
    ];

  networking.hostName = "installation04";
  # myNetwork.externalInterface = "enp1s0"; # Required for containers

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Virtualisation Settings
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
