variable "resource_group_name" {
  type        = string
  default     = "rg-devops-001"
  description = "Name of the resource group to be imported."
  nullable    = false
}

variable "vnet_name" {
  type        = string
  default     = "jccloudvnet1"
  description = "Name of the vnet to create"
}

variable "vnet_location" {
  type        = string
  default     = "uksouth"
  description = "The location of the vnet to create."
  nullable    = false
}

variable "address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "The address space that is used by the virtual network."
}

variable "bgp_community" {
  type        = string
  default     = null
  description = "(Optional) The BGP community attribute in format `<as-number>:<community-value>`."
}

variable "ddos_protection_plan" {
  type = object({
    enable = bool
    id     = string
  })
  default     = null
  description = "The set of DDoS protection plan configuration"
}

# If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "The DNS servers to be used with vNet."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetryinfo.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "vmsubnet_name" {
  type        = string
  default     = "vmsubnet"
  description = "A list of public subnets inside the vNet."
}

variable "vmsubnet_prefix" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "The address prefix to use for the subnet."
}

variable "appsubnet_name" {
  type        = string
  default     = "appsubnet"
  description = "A list of public subnets inside the vNet."
}

variable "appsubnet_prefix" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "The address prefix to use for the subnet."
}

variable "dbsubnet_name" {
  type        = string
  default     = "dbsubnet"
  description = "A list of public subnets inside the vNet."
}

variable "dbsubnet_prefix" {
  type        = list(string)
  default     = ["10.0.3.0/24"]
  description = "The address prefix to use for the subnet."
}

variable "tenant_id" {
  type        = string
  default     = "fa97859f-1a91-4ae1-ba3e-05a73b452efd"
  description = "The SP tenant ID."
}

variable "subscription_id" {
  type        = string
  default     = "58c4307d-1129-4116-a1e7-782415146818"
  description = "The subscription ID."
}

variable "client_id" {
  type        = string
  default     = "90367a60-e3ea-4618-9953-e85ce291ff39"
  description = "The SP application ID."
}
