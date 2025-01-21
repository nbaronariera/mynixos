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
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      qemu
      virtio-win
    ];
    users.groups.libvirtd.members = [ "nbr" ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    services.spice-vdagentd.enable = true;
    boot.kernelModules = [
      "kvm-amd"
      "kvm-intel"
    ];
  };
}
