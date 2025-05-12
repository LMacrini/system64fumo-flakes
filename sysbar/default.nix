{
  stdenv,
  lib,
  fetchFromGitHub,
  pkg-config,
  git,
  wrapGAppsHook4,
  gtkmm4,
  gtk4-layer-shell,
  jsoncpp,
  curl,
  dbus,
  wireplumber,
  playerctl,
  libnl,
  wayland-scanner,
  ...
}:

stdenv.mkDerivation {
  pname = "sysbar";
  version = "unstable-2025-05-02";

  src = fetchFromGitHub {
    owner = "System64fumo";
    repo = "sysbar";
    rev = "7040925b06617aabd9f8837fd4f9370bd45ae4c8";
    hash = "sha256-hWqzgWMcae8/SGcNZgpqF2dFPT5t6K4GHX2/apOxZHE=";
  };

  nativeBuildInputs = [
    pkg-config
    git
    wrapGAppsHook4
    wayland-scanner
    libnl
    curl
    dbus
    jsoncpp
    wireplumber
    playerctl
  ];

  buildInputs = [
    gtkmm4
    gtk4-layer-shell
  ];

  patches = [
    ./makefile.patch
  ];

  env.LIBNLDIR = "${lib.getDev libnl}/include/libnl3";

  installPhase = ''
    runHook preInstall
    install -Dm755 build/sysbar $out/bin/sysbar
    install -Dm755 build/libsysbar.so $out/lib/libsysbar.so
    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/sysbar \
      --set LD_LIBRARY_PATH $out/lib
  '';
}
