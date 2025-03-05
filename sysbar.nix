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
  version = "unstable-2025-02-23";

  src = fetchFromGitHub {
    owner = "System64fumo";
    repo = "sysbar";
    rev = "c77ca19bb36657e1f725e999d146a1bab0d49a3e";
    hash = "sha256-KVYz4YkLAtYlRfqCHdXGHK8z+ACJRHaXpB4TaqbKuVQ=";
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
