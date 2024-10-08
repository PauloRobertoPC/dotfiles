{ config, lib, pkgs, ... }:
{
     # Various packages related to virtualization, compatability and sandboxing
    home.packages = with pkgs; [
        # Virtual Machines and wine
        libvirt
        virt-manager
        qemu
        uefi-run
        lxc
        swtpm

        # Games
        bottles
        retroarchFull
        steam

        # Filesystems
        dosfstools
        ];

    home.file.".config/libvirt/qemu.conf".text = ''
        nvram = ["/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]
  '';

}
