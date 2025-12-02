# Module - Oracle Object Storage Bucket
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![OCI](https://img.shields.io/badge/provider-OCI-red)](https://registry.terraform.io/providers/oracle/oci/latest)

Module developed to standardize the creation of Oracle Object Storage Bucket.

## Compatibility Matrix

| Module Version | Terraform Version | OCI Version     |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.9.3 - v1.14.0  | 6.4.0 - 7.27.0  |

## Specifying a version

To avoid that your code get the latest module version, you can define the `?ref=***` in the URL to point to a specific version.
Note: The `?ref=***` refers a tag on the git module repo.

## Default use case plus RBAC
```hcl
module "osb-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-objectstorage-bucket?ref=v1.0.0" 
  compartment_id = <compartment id>
  name = "osb-vcp-prd-coe-001"
  namespace = <namespace>
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
  compartment = <compartment name>
  groups = ["group name 1", "group name 2"]
}
output "bucket-name" {
  value = module.osb-<region>-<env>-<system>-<id>.name
}
output "bucket-id" {
  value = module.osb-<region>-<env>-<system>-<id>.id
}
```

## Custom use case plus RBAC
```hcl
module "osb-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-objectstorage-bucket?ref=v1.0.0" 
  compartment_id = <compartment id>
  name = "osb-vcp-prd-coe-001"
  namespace = <namespace>
  retention_rules = {
    display_name = "rule 1"
    duration = {
      time_amount = <time_amount>
      time_unit = <time_unit>
    }
    time_rule_locked = <time_rule_locked>
  }
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }
  compartment = <compartment name>
  groups = ["group name 1", "group name 2"]
}
output "bucket-name" {
  value = module.osb-<region>-<env>-<system>-<id>.name
}
output "bucket-id" {
  value = module.osb-<region>-<env>-<system>-<id>.id
}
```

## Use case without RBAC
```hcl
module "osb-<region>-<env>-<system>-<id>" {    
  source = "git::https://github.com/danilomnds/terraform-oci-objectstorage-bucket?ref=v1.0.0" 
  compartment_id = <compartment id>
  name = "osb-vcp-prd-coe-001"
  namespace = <namespace> 
  defined_tags = {
    "IT.area":"infrastructure"
    "IT.department":"ti"    
  }  
}
output "bucket-name" {
  value = module.osb-<region>-<env>-<system>-<id>.name
}
output "bucket-id" {
  value = module.osb-<region>-<env>-<system>-<id>.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access_type | The type of public access enabled on this bucket | `string` | `NoPublicAccess` | No |
| auto_tiering | Set the auto tiering status on the bucket | `string` | `Disabled` | No |
| compartment_id | The ID of the compartment in which to create the bucket | `string` | n/a | `Yes` |
| defined_tags | Defined tags for this resource | `map(string)` | n/a | No |
| freeform_tags | Free-form tags for this resource | `map(string)` | n/a | No |
| kms_key_id | The OCID of a master encryption key used to call the Key Management service to generate a data encryption key or to encrypt or decrypt a data encryption key | `string` | n/a | No |
| metadata | Arbitrary string, up to 4KB, of keys and values for user-defined metadata | `map(string)` | n/a | No |
| name | The name of the bucket | `string` | n/a | `Yes` |
| namespace | The Object Storage namespace used for the request | `string` | n/a | `Yes` |
| object_events_enabled | Whether or not events are emitted for object state changes in this bucket  | `bool` | `false` | No |
| retention_rules | a block as defined below | `object({})` | n/a | No |
| storage_tier | The type of storage tier of this bucket | `string` | n/a | No |
| versioning | Set the versioning status on the bucket | `string` | n/a | No |
| groups | list of azure AD groups that will manage objects inside the bucket | `list(string)` | `[]` | No |
| compartment | the compartment name where the policy will be created | `string` | n/a | No |
| home_region | home region for policy creation | `string` | n/a | No |
| tenancy_ocid | required for compartment tree search | `string` | n/a | No |
| user_ocid | Terraform user | `string` | n/a | No |
| fingerprint | Terraform user fingerprint | `string` | n/a | No |
| private_key_path | Terraform user private_key_path | `string` | n/a | No |

# Object variables for blocks

| Variable Name (Block) | Parameter | Description | Type | Default | Required |
|-----------------------|-----------|-------------|------|---------|:--------:|
| retention_rules | display_name | A user-specified name for the retention rule  | `string` | n/a | `Yes` |
| retention_rules | optional sub-block duration (time_amount) |  The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp  | `number` | n/a | `Yes` |
| retention_rules | optional sub-block duration (time_amount) | The unit that should be used to interpret timeAmount  | `string` | n/a | `Yes` |
| retention_rules | time_rule_locked | The date and time as per RFC 3339 after which this rule is locked and can only be deleted by deleting the bucket  | `string` | n/a | No |

## Output variables

| Name | Description |
|------|-------------|
| name | bucket name|
| id | bucket id |

## Documentation
Oracle Object Storage Bucket: <br>
[https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_bucket](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_bucket)