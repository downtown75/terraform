resource "proxmox_virtual_environment_container" "tf_demo" {
  description   = "Managed by Terraform"
  node_name     = "qnet"
  vm_id         = 102
  tags          = ["terraform", "demo"]

  unprivileged  = true
  started       = true
  start_on_boot = true

  features {
    nesting = true
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 512
  }

  disk {
    datastore_id = "local"
    size         = 4
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

  initialization {
    hostname = "tf-demo"

    ip_config {
      ipv4 {
        address = "192.168.40.21/24"
        gateway = "192.168.40.1"
      }
    }

    user_account {
      keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoRpJk/b4KhLfJesM7gZH2+O0AJOSVhSNnqB3rP6uWmInECi5M4C6wpuVqZyW3VB/JXddvKvDo2itH8qBN2vROlcDQM3mek19OHali2lF9itGZdC6IN6SISR2KgzWOY3BLKCP1PTA+6vuxYn2gKyLdSeu7gGlfHIIsLnP38Y0J7xmezIDg0Ah5J3Y+hcAtfjXCBEzJGHlP1cbihsj68SeSRPkeZhoREJVqasynChDCBy/aNMdAToLBk56nRNdi9Tody6Nk4McfO5KeRwGg9TQlftvMSYooQKosjx78kQe3UR6i9ef9lZ+8NfKkZK/gbV1xbVt8QKP5Jt4sWMzxZUzEX8RiRMzQAu9CFP9Bxt5wzyO26cHgY3ETWd54kVoIKG2AaKqmiiZ+HbKet0jzlCiAOR8eL/JkUD3YqHuKbyxa1fLxc/RGklqxZBN2wtfcIAAvqMA0XwxHWqPG28EYiyb+7fhluCoyP0c+qrP/yjWVPPZwgHKuD7NSTk1wRVBVkrM= root@qnet",
      ]
    }

    dns {
      servers = ["1.1.1.1", "9.9.9.9"]
    }
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-13-standard_13.6-1_amd64.tar.zst"
    type             = "debian"
  }
}

output "tf_demo_id" {
  value = proxmox_virtual_environment_container.tf_demo.id
}

output "tf_demo_ip" {
  value = "192.168.40.21"
}
