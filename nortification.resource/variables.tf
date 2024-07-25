# Variables

## Provider Variables
### tenant ocid
variable "tenancy_ocid" {
  type = string
}

### compartment_ocid
variable "compartment_ocid" {
  type        = string
}

### OCI region (ex:ap-tokyo-1, us-phoenix-1, etc...)
variable "region" {
  type        = string
}

## etc variable
### nortification endpoint 
variable "endpoint" {
  description = "アクセス先URL"
  default = "https://test.com"   ## URLを記載
}

## policy 
### tools のtenacy name 
variable "tool_tenancy_name"  {
  default = "indigotestsandbox12"  ## tool tenancy name を記載
}

### tools のtenacy ocid
variable "tool_tenancy_ocid"  {
  default = "ocid1.tenancy.oc1..aaaaaaaa6u76bpjwih24sphv3nkm7wb5negilj5c7yhduekfiem3t5einyha"  ## tool tenancy ocdi を記載
}

### tools の 動的groupの名前
variable "tool_group_name" {
  default = "notification_tool_gw_dynamic_group"  ## tool tenancy の group_name  を記載
}

### tools の 動的 group  の ocid
variable "tool_group_ocid" {
  default = "ocid1.fnfunc.oc1.ap-tokyo-1.aaaaaaaa55znkh4kusq4itkinbm3riumk6sm3bb5ndoqpvnkygjqiiXXXXX"  ## tool tenancy の gourp_name の ocid
}
