{ lib, 
  rustPlatform, 
  fetchFromGitHub, 
  pkg-config, 
  clang,
  libclang,
  cmake,
  openssl, 
  pipewire, 
  wayland, 
  libxkbcommon, 
  libva,
  pam
}:

rustPlatform.buildRustPackage rec {
  pname = "lamco-rdp-server";
  version = "1.4.5";

  src = fetchFromGitHub {
    owner = "lamco-admin";
    repo = "lamco-rdp-server";
    rev = "v${version}";
    hash = "sha256-GUhfn595Wo8D5NqyVzrlE1Y5X4k6NpCplAYMqmf45Xw=";
  };

  cargoHash = "sha256-6R3WboCVdEralf9gw1mmOl80HCMafa0l8dzu/3kNfJw=";

  nativeBuildInputs = [
    pkg-config
    clang
    libclang
    cmake
  ];

  buildInputs = [
    openssl
    pipewire
    wayland
    libxkbcommon
    libva
    pam
  ];

  LIBCLANG_PATH = "${libclang.lib}/lib";

  # Adjust according to the features you actually want.
  cargoBuildFlags = [
    "--features"
    "gui,wayland,wl-clipboard,vaapi,pam-auth"
  ];

  # Patches required for building with new libva 
  postPatch = ''
    patch -d "$cargoDepsCopy" -p1 < ${./patches/cros-libva-vp9-nix.patch}
  '';

  meta = {
    description = "Wayland-native RDP server for Linux";
    homepage = "https://github.com/lamco-admin/lamco-rdp-server";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "lamco-rdp-server";
  };
}
