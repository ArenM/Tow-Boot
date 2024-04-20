{ config, lib, pkgs, ... }:

let
  inherit (lib)
    mkIf
  ;
  inherit (config.Tow-Boot) buildUBoot;
in
{
  device = {
    manufacturer = "Hardkernel";
    name = "ODROID-N2";
    identifier = "odroid-N2";
    productPageURL = "https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram-2/";
    supportLevel = "best-effort";
  };

  hardware = {
    soc = "amlogic-s922x";
    # Only enable SPI build with Tow-Boot; mainline doesn't have the patch.
    SPISize = mkIf (!buildUBoot) (8 * 1024 * 1024);
  };

  Tow-Boot = {
    defconfig = "odroid-n2_defconfig";
    config = [
      (helpers: with helpers; {
        USE_PREBOOT = yes;
        PREBOOT = freeform ''"usb start ; usb info"'';
        SF_DEFAULT_SPEED = mkIf (!buildUBoot) (freeform ''52000000'');
      })
    ];
    builder.additionalArguments = {
      FIPDIR = "${pkgs.Tow-Boot.amlogicFirmware}/odroid-n2";
    };
  };
}
