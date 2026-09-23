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

  postPatch = ''
    substituteInPlace "$cargoDepsCopy/source-registry-0/cros-libva-0.0.13/src/buffer/vp9.rs" \
      --replace-fail \
        'va_reserved: Default::default(),' \
        'va_reserved: Default::default(),
              ..Default::default()'

    mkdir -p licenses
    cp ${./licenses/OpenH264-BINARY_LICENSE.txt} \
       licenses/OpenH264-BINARY_LICENSE.txt
  '';

  meta = {
    description = "Wayland-native RDP server for Linux";
    homepage = "https://github.com/lamco-admin/lamco-rdp-server";
    license = with lib.licenses; [ mit asl20 ];
    mainProgram = "lamco-rdp-server";
  };
}
