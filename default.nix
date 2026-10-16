{ fetchFromGitHub, gobject-introspection, lib, meson, glib, stdenv, mutter
, pkg-config, cmake, cairo, gsettings-desktop-schemas, wayland, libGL, libxfixes
, libxi, atk, ninja }:

stdenv.mkDerivation {
  pname = "gnome-rounded-blur";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "kancko";
    repo = "gnome-rounded-blur";
    tag = "v1.0.1";
    hash = "sha256-sknZgT3wYJeTjJ9wVQMn0d5p92Y41MfHhWIcj7jCEmA=";
    fetchSubmodules = false;
  };

  patches = [ ];

  nativeBuildInputs = [ meson pkg-config cmake gobject-introspection ninja mutter.dev ];

  # preConfigure = ''
  #   echo "=== PKG_CONFIG_PATH before: $PKG_CONFIG_PATH"
  #   ls ${mutter.dev}/lib/pkgconfig/ || echo "=== no pkgconfig dir in mutter.dev"
  #   pkg-config --exists mutter-clutter-17 && echo "=== mutter-clutter-17 FOUND before" || echo "=== mutter-clutter-17 NOT FOUND before"
  #   export PKG_CONFIG_PATH="${mutter.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
  #   echo "=== PKG_CONFIG_PATH after: $PKG_CONFIG_PATH"
  #   pkg-config --exists mutter-clutter-17 && echo "=== mutter-clutter-17 FOUND after" || echo "=== mutter-clutter-17 NOT FOUND after"
  # '';

  # postPatch = ''
  #   sed -i "s/mutter_api_version = '17'/mutter_api_version = '18'/" meson.build
  #   sed -i "s/mutter_req = '>= 49.0'/mutter_req = '>= 50.0'/" meson.build
  # '';

  buildInputs = [
    mutter
    glib
    cairo
    gsettings-desktop-schemas
    wayland
    libGL
    libxfixes
    libxi
    atk
  ] ++ (mutter.buildInputs or [ ]) ++ (mutter.propagatedBuildInputs or [ ]);

  meta = with lib; {
    description =
      "A standalone library providing Blur.BlurEffect with corner radius support for GNOME Shell extensions.";
    homepage = "https://github.com/kancko/gnome-rounded-blur";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
  };
}
