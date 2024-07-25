# Variables

## Provider Variables
### tenant ocid
variable "tenancy_ocid" {
  description = "自テナントのOCID（ルートコンパートメントのOCID）"
  type        = string
}

### Compartment OCID
variable "compartment_ocid" {
  description = "コンパートメントocid"
  type        = string
}

variable "region" {
   type        = string
}

## etc variable
### image name
variable "image" {
  description = "起動するimagesのレジストリ"
  default = "nrt.ocir.io/nrmvoue4fchi/test/nginx-test:latest"  
}

### deployment paths
variable "deploy_path_prefix" {
  description = "Gateway の デプロイメント パス接頭辞"
  default = "/v1"   
}

variable "route_path" {
  description = "Gateway の デプロイメント ルーティング　PATH"
  default = "/tool_admin_login_notifier" 
}

### secret-key path
variable "api_key_private_path" {
  description = "function の環境変数 のsecret-keyのパス"
  default = "./.oci/oci-key.pem"
}

## policy
### policy
variable "child_tenancy" {
  description = "子テナントの登録"
  type = list(object({
    name = string
    ocid = string
  }))
  default = [  ## 子テナントの名前とOCIDを全部記載
    { name = "IndigoTestSandbox13", ocid = "ocid1.tenancy.oc1..aaaaaaaa35n2xnu5rbibiumg5roh3xsqu2wqhievzxzaay7weenvl5fxxjoa" },
    { name = "IndigoTestSandbox12", ocid = "ocid1.tenancy.oc1..aaaaaaaa6u76bpjwih24sphv3nkm7wb5negilj5c7yhduekfiem3t5einyha" },
  ]
}

## idenfity
### group_name
variable "notification_group_name" {
  description = "ユーザのグループ名"
  default = "notification_tool_fn_group"
}

### dynamic group
variable "dynamic_group_name" {
  default = "notification_tool_gw_dynamic_group"
}

### User name
variable "tool_user_name" {
  description = "ユーザ名"
  default = "notification_local_user"
}
variable "tool_user_email" {
  description = "ユーザ名のメールアドレス"
  default = "XXXX@mail.com"
}

### pub-key path
variable "api_key_pub_path" {
  description = "pub-key"
  default = "./.oci/oci-key_pub.pem"
}
