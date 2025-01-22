# TODO: move to a devshell flake
{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      iverilog
      yosys
      netlistsvg
      # yosys-synlig
      # verilator
      logisim-evolution
      platformio-core
      digital
      haskellPackages.sv2v
      # ripes # fix build
    ];
  };
}
