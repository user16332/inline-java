{ ghc }:

with (import <nixpkgs> {});

let
  openjdk = openjdk8;
  jvmlibdir =
    if stdenv.isLinux
    then "${openjdk}/lib/openjdk/jre/lib/amd64/server"
    else "${openjdk}/jre/lib/server";
in
haskell.lib.buildStackProject {
  name = "sparkle";
  buildInputs = [ openjdk ];
  inherit ghc;
  extraArgs = ["--extra-lib-dirs=${jvmlibdir}"];
  # XXX Workaround https://ghc.haskell.org/trac/ghc/ticket/11042.
  LD_LIBRARY_PATH = [jvmlibdir];
}