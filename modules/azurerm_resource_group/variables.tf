variable "rgs" {
  description = "Map of Resource Groups"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "rgs" {

}
variable "rg_tags" {
  
}