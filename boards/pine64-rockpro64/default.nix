{
  device = {
    manufacturer = "PINE64";
    name = "ROCKPro64";
    identifier = "pine64-rockpro64";
  };

  hardware = {
    soc = "rockchip-rk3399";
    SPISize = 16 * 1024 * 1024; # 16 MiB
  };

  Tow-Boot = {
    defconfig = "rockpro64-rk3399_defconfig";
    patches = [
      ./0001-rockpro64-rk3399-Configure-SPI-flash-boot-offset.patch
    ];
  };
}
