# modules/virtualisation/qemu

{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        package = pkgs.qemu_kvm;

        swtpm.enable = true;

        # Optional for Windows VMs
        runAsRoot = true;
      };
    };

    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    virtio-win
  ];
}
