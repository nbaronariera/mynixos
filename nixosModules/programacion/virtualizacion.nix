{ config, pkgs, lib, ... }:

let
  enableKVM = config.my.enableKVM or false;
in {
  options.my.enableKVM = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable KVM virtualization and VirtManager in the system";
  };

  config = lib.mkIf enableKVM {
    # Carga siempre estos módulos:
    boot.kernelModules = [ "kvm" "kvm_amd" ];

    # Activa AMD IOMMU (necesario si haces passthrough, pero no daña si no)
    boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];

    # Crea el grupo kvm y añade tu usuario (reemplaza "nbr")
    users.groups.kvm = {
      gid = 151;  # un número arbitrario, no usado
      members = [ "nbr" ];
    };

    # Paquetes para virtualización
    environment.systemPackages = with pkgs; [
      qemu
      libvirt
      virt-manager
    ];

    # Configura libvirtd (no es estrictamente necesario para /dev/kvm,
    # pero es útil si quieres usar virt-manager más tarde)
    virtualisation.libvirtd.enable = true;
    users.groups.libvirtd.members = [ "nbr" ];
  };
}
