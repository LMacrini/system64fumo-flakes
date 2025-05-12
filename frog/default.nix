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
  version = "unstable-2025-03-18";

  src = fetchFromGitHub {
    owner = "System64Fumo";
    repo = "frog";
    rev = "178b7de000c524620a1aa89c99dd2934afb508fe";
    hash = "sha256-xsWONRJNrfIuztWpqX2QEIJRuVPmWVnBZFvmy4m91Ak=";
  };


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
    cp build/frog $out/bin/frogfm
    mkdir -p $out/share/sys64/frog
    cp config.conf $out/share/sys64/frog
    cp style.css $out/share/sys64/frog
    runHook postInstall
  '';
}
