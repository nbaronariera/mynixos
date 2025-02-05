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
      virtio-win
    ];

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["nbr"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;


    services.spice-vdagentd.enable = true;
    services.spice-webdavd.enable = true;
    services.qemuGuest.enable = true;
  };
}
