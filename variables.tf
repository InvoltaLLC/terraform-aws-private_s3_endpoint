variable "vpc_id" {
  type = string
  description = "The ID of the VPC to associate this endpoint with"
  
  validation {
    condition     = can(regex("(^vpc-[0-9a-f]{8}$|^vpc-[0-9a-f]{17}$)",var.vpc_id))
    error_message = "The provided value does not appear to be a valid VPC ID"
  }
}

variable "route_table_ids" {
  type = list(string)
  description = "A list of IDs of route tables to associate this endpoint with"

  validation {
    condition = length([
      for o in var.route_table_ids : true
      if can(regex("(^rtb-[0-9a-f]{8}$|^rtb-[0-9a-f]{17}$)",o))
    ]) == length(var.route_table_ids)
    error_message = "One or more of the provided route table IDs appear to be invalid"
  }
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "allowed_buckets" {
  type = list(string)
  description = "A list of bucket names this endpoint is allowed to provide access to"
}