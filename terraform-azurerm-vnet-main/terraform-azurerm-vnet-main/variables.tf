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
  default     = "10.0.1.0/24"
  description = "The address prefix to use for the subnet."
}

variable "appsubnet_name" {
  type        = string
  default     = "vmsubnet"
  description = "A list of public subnets inside the vNet."
}

variable "appsubnet_prefix" {
  type        = list(string)
  default     = "10.0.2.0/24"
  description = "The address prefix to use for the subnet."
}

variable "dbsubnet_name" {
  type        = string
  default     = "vmsubnet"
  description = "A list of public subnets inside the vNet."
}

variable "dbsubnet_prefix" {
  type        = list(string)
  default     = "10.0.3.0/24"
  description = "The address prefix to use for the subnet."
}

