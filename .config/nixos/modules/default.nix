{ lib, ... }:

{
  imports = [
    ./cups/default.nix
    ./qmk.nix
    ./steam.nix
    ./syncthing.nix
  ];

  cups.enable = lib.mkDefault true;
  qmk.enable = lib.mkDefault true;

}
