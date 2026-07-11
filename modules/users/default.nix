# modules/users.nix

{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."mitchw" = {
    isNormalUser = true;
    description = "Mitch Wilkinson";
    shell = pkgs.zsh;
    extraGroups = [ 
      "networkmanager" 
      "wheel" 
      "libvirtd"
      "kvm"
      "docker"
    ];
  };
}
