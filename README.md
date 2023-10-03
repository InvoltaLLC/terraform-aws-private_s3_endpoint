# Provision S3 Endpoints with Terraform

## Overview

This module creates a private endpoint for S3 consumption within a Virtual Private Cloud.  In addition to creating the endpoint, this module takes care of associating the endpoint with an arbitrary number of route tables, and allows you to specify which buckets are available via the created endpoint.  Additionally, S3 bucket policies for the specified buckets are created to allow access from the specified VPC.

> Note: Any existing bucket policies will be overwritten by this module.  If this behavior is undesired, consider using the ```-target``` parameter while applying the configuration.

## Inputs

The following variables are defined by this module:

| Var Name | Type | Description |
| - | - | - |
| vpc_id | string | The ID of the VPC to associate this endpoint with.  The ID will be of the form ```vpc-01234567``` or ```vpc-0123456789abcdef0```.  Pre-flight checks will validate the format of the ID, but not if the VPC actually exists. |
| route_table_ids | list(string) | IDs of the route tables to associate this endpoint with.  All specified route tables will have a route added which points S3 traffic to the created endpoint.  IDs will be of the form ```rtb-01234567``` or ```rtb-0123456789abcdef0```.  Pre-flight checks will validate the format of the ID, but not if the route table actually exists. |
| allowed_buckets | list(string) | A list of S3 bucket names to allow access to via this endpoint.  Specified buckets will be added to the endpoint policy, and have bucket policies created which allow access from the specified VPC. |
| tags | map(string) | Key/value pairs to tag created resources with.  The map key will become the tag key, and the map value will become the tag value. |

### Example tfvars File

```hcl
vpc_id = "vpc-09c3cf0febfe156e6"

route_table_ids = [
    "rtb-016535e748bd096b9",
    "rtb-0f832cc5d6770702f",
]

allowed_buckets = [ 
    "myfirstbucket", 
    "mysecondbucket" 
]
```

## Outputs

N/A

## Example Usage

### Add Module to a Configuration

```hcl
module "endpoint" {
  source = "./terraform-aws-private_s3_endpoint"

  vpc_id = var.vpc_id
  route_table_ids = var.route_table_ids
  allowed_buckets = var.allowed_buckets
  tags = var.tags
}
```

### Apply via CLI
```
terraform apply -var-file my.tfvars
```