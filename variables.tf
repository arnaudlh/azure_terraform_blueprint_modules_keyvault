variable "resource_group_name" {
  description = "(Required) Name of the resource group to deploy the KV"
}

variable "location" {
  description = "(Required) Define the region where the resources will be created"
}

variable "name" {
  description = "(required) name of the KV to be deployed"
}

variable "prefix" {
  description = "(required) prefix of the KV to be deployed"
}