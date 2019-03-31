let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  channel = nixpkgs.rustChannelOf {
  channel = "stable";
};
in
  with nixpkgs;
  stdenv.mkDerivation rec {
    name = "ydcv";

    buildInputs = [
      channel.rust
      pkgconfig
      openssl
      dbus
      python3
      xorg.libxcb
    ];

    shellHook = ''
      export OPENSSL_DIR="${openssl.dev}"
      export OPENSSL_LIB_DIR="${openssl.out}/lib"
    '';
  }
