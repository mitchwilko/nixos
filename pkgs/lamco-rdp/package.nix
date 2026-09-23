{ lib, 
  rustPlatform, 
  fetchFromGitHub, 
  pkg-config, 
  openssl, 
  pipewire, 
  wayland, 
  libxkbcommon, 
  libei, 
  pam
}:

rustPlatform.buildRustPackage rec {
  pname = "lamco-rdp-server";
  version = "1.4.5";

  src = fetchFromGitHub {
    owner = "lamco-admin";
    repo = "lamco-rdp-server";
    rev = "v${version}";
    hash = lib.fakeHash;
  };

  cargoHash = lib.fakeHash;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
    pipewire
    wayland
    libxkbcommon
    libei
    pam
  ];

  # Adjust according to the features you actually want.
  cargoBuildFlags = [
    "--release"
    "--features"
    "gui,wayland,wl-clipboard,vaapi,pam-auth"
  ];

  meta = {
    description = "Wayland-native RDP server for Linux";
    homepage = "https://github.com/lamco-admin/lamco-rdp-server";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "lamco-rdp-server";
  };
}
