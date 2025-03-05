{
  stdenv,
  fetchFromGitHub,
  gtkmm4,
  gtk4-layer-shell,
  wrapGAppsHook4,
  xdg-utils,
  pkg-config,
  gst_all_1,
  util-linux,
  libudev-zero,
  ...
}:
stdenv.mkDerivation {
  pname = "frogfm";
  version = "unstable-2025-02-05";

  src = fetchFromGitHub {
    owner = "System64Fumo";
    repo = "frog";
    rev = "147802b112d7abd1dbfc8f13214200b339899d45";
    hash = "sha256-wtn/1nND+8DW9j+ovdUiB/puM9EEraC16wEAdOjO+WA=";
  };

  # PREFIX = "$out";

  buildInputs = [
    gtkmm4
    gtk4-layer-shell
    wrapGAppsHook4
    xdg-utils
    pkg-config
    util-linux
    libudev-zero
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp build/frog $out/bin
    mkdir -p $out/share/sys64/frog
    cp config.conf $out/share/sys64/frog
    cp style.css $out/share/sys64/frog
    runHook postInstall
  '';
}
