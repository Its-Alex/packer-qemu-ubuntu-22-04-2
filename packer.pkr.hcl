packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

source "qemu" "ubuntu_22_04_2" {
    vm_name                 = "ubuntu-2004-amd64-qemu-build"
    headless                = true
    memory                  = 4096
    disk_image              = false
    accelerator             = "kvm"
    disk_size               = "12000M"
    shutdown_command        = "sudo shutdown -P now"

    boot_command            = [
        "<wait>e<down><down><down><end>",
        " autoinstall net.ifnames=0 biosdevname=0 systemd.unified_cgroup_hierarchy=0",
        " cloud-config-url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/user-data",
        " fsck.mode=skip \"ds=nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"",
        "<F10>"
    ]
    boot_wait               = "3s"
    boot_key_interval       = "50ms"

    http_directory          = "http"

    iso_checksum            = "5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
    iso_url                 = "http://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso"

    ssh_username            = "ubuntu"
    ssh_password            = "password"
    ssh_timeout             = "20m"
}

build {
    sources = ["source.qemu.ubuntu_22_04_2"]

    post-processor "vagrant" {
        keep_input_artifact = true
        compression_level   = 9
        output              = "output-vagrant/package.box"
    }
}
