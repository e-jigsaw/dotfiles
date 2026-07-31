# nixpkgs の elektroid は alsa-lib / libpulseaudio を無条件で buildInputs に持つため
# darwin では eval 時点で弾かれる。configure.ac は host_os=darwin* を検出して
# RtMidi / RtAudio バックエンドに切り替えるので、その2つに差し替えた darwin 向け定義。
{
  lib,
  stdenv,
  fetchFromGitHub,
  autoreconfHook,
  gettext,
  pkg-config,
  wrapGAppsHook3,
  glib,
  gtk3,
  json-glib,
  libsamplerate,
  libsndfile,
  libzip,
  rtaudio,
  rtmidi,
  rubberband,
  zlib,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "elektroid";
  version = "3.3.2";

  src = fetchFromGitHub {
    owner = "dagargo";
    repo = "elektroid";
    rev = finalAttrs.version;
    hash = "sha256-ozpc2+sXOedmYYXdIH6HibGszLyKsT8QYS0Trhem6kI=";
  };

  # EBADSLT は Linux 固有の errno で macOS の errno.h に無い。
  # upstream master では 3.3.2 以降にどちらの箇所も EINVAL へ置き換えられている。
  postPatch = ''
    substituteInPlace src/connectors/elektron.c \
      --replace-fail "-EBADSLT" "-EINVAL"
  '';

  nativeBuildInputs = [
    autoreconfHook
    gettext # AM_GNU_GETTEXT([external]) が autopoint を要求する
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    glib
    gtk3
    json-glib
    libsamplerate
    libsndfile
    libzip
    rtaudio
    rtmidi
    rubberband
    zlib
  ];

  meta = {
    description = "Sample and MIDI device manager";
    homepage = "https://github.com/dagargo/elektroid";
    license = lib.licenses.gpl3Only;
    mainProgram = "elektroid";
    platforms = lib.platforms.darwin;
  };
})
