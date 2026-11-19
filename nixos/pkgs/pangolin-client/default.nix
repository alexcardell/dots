{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  wrapGAppsHook3,
  gtk3,
  webkitgtk_4_1,
  glib-networking,
}:
let
  sources = {
    x86_64-linux = {
      arch = "amd64";
      hash = "sha256-CvLaiaFyS5GrQ9nDyWkRx2l3sXO3Cl2mDhHb6UuAIxU=";
    };
    aarch64-linux = {
      arch = "arm64";
      hash = "sha256-fRzqlUPN3/4psotg3TknL3+E/hzLEuHK0VhKwawaPOk=";
    };
  };
  source =
    sources.${stdenv.hostPlatform.system}
      or (throw "pangolin-client: unsupported platform ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation (finalAttrs: {
  pname = "pangolin-client";
  version = "0.2.0";

  src = fetchurl {
    url = "https://github.com/fosrl/windows-linux/releases/download/linux-${finalAttrs.version}/pangolin-client-${source.arch}-${finalAttrs.version}.tar.gz";
    inherit (source) hash;
  };

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook3
  ];
  buildInputs = [
    gtk3
    webkitgtk_4_1
    glib-networking
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 bin/pangolin-client "$out/bin/pangolin-client"
    mkdir -p "$out/share" "$out/etc/xdg/autostart"
    cp -r share/. "$out/share/"
    cp etc/xdg/autostart/*.desktop "$out/etc/xdg/autostart/"
    install -Dm644 LICENSE "$out/share/licenses/pangolin-client/LICENSE"

    substituteInPlace "$out/share/applications/pangolin-client.desktop" \
      "$out/etc/xdg/autostart/pangolin-client-autostart.desktop" \
      --replace-fail "Exec=pangolin-client" "Exec=$out/bin/pangolin-client"

    runHook postInstall
  '';

  meta = {
    description = "Pangolin desktop client for secure remote access";
    homepage = "https://github.com/fosrl/windows-linux";
    license = lib.licenses.agpl3Only;
    mainProgram = "pangolin-client";
    platforms = builtins.attrNames sources;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
