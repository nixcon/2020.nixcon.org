{ pkgs ? import ./nixpkgs {} }:

let
  gitignoreSrc = pkgs.fetchFromGitHub {
    owner = "hercules-ci";
    repo = "gitignore";
    rev = "647d0821b590ee96056f4593640534542d8700e5";
    sha256 = "sha256:0ks37vclz2jww9q0fvkk9jyhscw0ial8yx2fpakra994dm12yy1d";
  };
  inherit (import gitignoreSrc { inherit (pkgs) lib; }) gitignoreSource;
in

pkgs.stdenv.mkDerivation {
  name = "nixcon-website";

  src = gitignoreSource ./.;

  buildInputs = with pkgs; [
    glibcLocales
    (haskellPackages.ghcWithPackages (ps: with ps; [
      hakyll
      hakyll-images
      hakyll-sass
    ]))
  ];

  LC_ALL = "en_US.UTF-8";

  buildPhase = ''
    ghc --make site.hs
    ./site build
  '';

  installPhase = ''
    mkdir $out
    cp -r _site/* $out
  '';
}
