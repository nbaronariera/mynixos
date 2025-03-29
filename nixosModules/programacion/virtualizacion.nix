{
  config,
  pkgs,
  lib,
  ...
}:

let
  enableKVM = config.my.enableKVM or false;
in
{
  options.my.enableKVM = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable KVM virtualization and VirtManager in the system";
  };

  config = lib.mkIf enableKVM {

    boot = {
      kernelParams = [
        "intel_iommu=on"
        "iommu=pt"
      ];
      kernelModules = [
        "kvm-intel"
        "vfio_pci"
        "vfio_iommu_type1"
        "vfio"
      ];
      extraModprobeConfig = ''
        options vfio-pci ids=10de:1f11,10de:10f9
        options vfio-pci disable_vga=1
      '';
      initrd.availableKernelModules = [
        "vfio"
        "vfio_iommu_type1"
        "vfio_pci"
      ];
    };

    environment.systemPackages = with pkgs; [
      virtio-win
      qemu
    ];

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "nbr" ];
    virtualisation.libvirtd.enable = true;
    virtualisation.libvirtd.qemu.runAsRoot = true;

    virtualisation.spiceUSBRedirection.enable = true;

    services.spice-vdagentd.enable = true;
    services.spice-webdavd.enable = true;
    services.qemuGuest.enable = true;

    systemd.services.libvirtd = {
      enable = true;
      after = [ "network.target" ];
    };

  };
}
