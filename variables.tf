variable "proxmox_endpoint" {
  type        = string
  description = "Proxmox VE API endpoint URL"
  default     = "https://192.168.40.5:8006/"
}

variable "proxmox_api_token" {
  type        = string
  description = "Proxmox API token (user@realm!tokenid=secret)"
  sensitive   = true
}

variable "proxmox_insecure" {
  type        = bool
  description = "Skip TLS verification (self-signed PVE certificates)"
  default     = true
}
