# Config file for Roland (Rasp Pi)
# Currently set up for temp virtualisation

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware.nix
      ../../modules/common
      ../../modules/nixos
      ../../modules/nixos/networking/nat.nix
      ../../modules/nixos/containers/dns.nix
      ../../modules/nixos/containers/proxy.nix
    ];

  # Raspberry Pi firmware
  hardware.enableRedistributableFirmware = true;

  # 1 GiB FAT32 boot partition + remaining space for NixOS
  fileSystems = {
  #   "/boot" = {
  #     device = "/dev/disk/by-label/BOOT";
  #     fsType = "vfat";
  #     options = [ "fmask=0022" "dmask=0022" ];
  #   };

    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  networking.hostName = "roland";
  # myNetwork.externalInterface = "enp1s0"; # Required for containers

  nixpkgs.buildPlatform = "x86_64-linux";

  boot.zfs.forceImportRoot = false;
  boot = {
    kernelParams = ["cma=320M"];
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
  };
  hardware.raspberry-pi.firmware = {
    enable = true;
    uboot.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
