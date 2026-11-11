{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
  libcap_ng,
}:
let
  sources = {
    x86_64-linux = {
      url = "https://github.com/superradcompany/microsandbox/releases/download/v0.7.14/microsandbox-linux-x86_64.tar.gz";
      hash = "sha256-NNSac4hoXw6iS/vuz2hkpEcYlZtXCH8ddIF3VnLblYU=";
    };
    aarch64-linux = {
      url = "https://github.com/superradcompany/microsandbox/releases/download/v0.7.14/microsandbox-linux-aarch64.tar.gz";
      hash = "sha256-oMVM0GvqTSpb0/wpEGP48vXgcyMtt49oYMUnki7HGQY=";
    };
    aarch64-darwin = {
      url = "https://github.com/superradcompany/microsandbox/releases/download/v0.7.14/microsandbox-darwin-aarch64.tar.gz";
      hash = "sha256-nMK9KHTMGqmMsTlCmpSCgwseZLSCVaqfQKJbiXmiOp8=";
    };
  };
in
stdenv.mkDerivation {
  pname = "microsandbox";
  version = "0.7.14";
  src = fetchurl (sources.${stdenv.hostPlatform.system} or (throw "microsandbox: unsupported platform ${stdenv.hostPlatform.system}"));

  nativeBuildInputs = if stdenv.isLinux then [ autoPatchelfHook ] else [ makeWrapper ];
  buildInputs = lib.optionals stdenv.isLinux [ libcap_ng stdenv.cc.cc.lib ];
  appendRunpaths = lib.optional stdenv.isLinux "${placeholder "out"}/lib";
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin" "$out/lib"
  '' + (if stdenv.isLinux then ''
    install -m755 msb "$out/bin/msb"
    install -m644 libkrunfw.so.5.6.1 "$out/lib/"
    ln -s libkrunfw.so.5.6.1 "$out/lib/libkrunfw.so.5"
    ln -s libkrunfw.so.5 "$out/lib/libkrunfw.so"
  '' else ''
    install -Dm755 msb "$out/libexec/msb"
    install -m644 libkrunfw.5.dylib "$out/lib/"
    ln -s libkrunfw.5.dylib "$out/lib/libkrunfw.dylib"
    makeWrapper "$out/libexec/msb" "$out/bin/msb" \
      --prefix DYLD_LIBRARY_PATH : "$out/lib"
  '') + ''
    ln -s msb "$out/bin/microsandbox"
    runHook postInstall
  '';

  meta = {
    description = "Self-hostable sandbox for running untrusted code in microVMs";
    homepage = "https://microsandbox.dev/";
    license = lib.licenses.asl20;
    mainProgram = "msb";
    platforms = builtins.attrNames sources;
  };
}
