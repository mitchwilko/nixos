#/modules/common/default.nix

{ config, pkgs, ... }:

{
  imports = [
    # ./nh
  ];

  # Allow for closed source Packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.secret-key-files = [ "/etc/nix/signing-key.sec" ];
  nix.settings.trusted-public-keys = [ 
    "mpswserver:teaiSVBljUDon8wwv4XE9ZNZiNMjuAzqHQL4CSTJraI="
    "mpswthinkpad:PIvTxwkPtlndAAZLiSllQO36MZ6YUk2/SfuIEPSRAIg="
    "mpswmacbook:kMOMw686wAgotn/Ju4zPAu/4ITYA5MHZjAs/8xqXiIk="
    "installation01:brSpETb7dDQZeijrf2frw0pKlZETJKzlblKcL9DNa3s="
    "harvest:QsnfDXzcpdLxoXbb4jfPzbzx2+fOaYoitBscAFvpT0I="
    "ellas-imac:k/vvxhtqmvdQd/KSp5kl/A9VHhYmp9z9Gl7h13jfOXg=%"
  ];
}
