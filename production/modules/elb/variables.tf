# ######################
# Route 53
# ######################
# route 53 host name
variable "hosts" {
  description = "route 53 host name"
  type = map(string)
  default ={
    "api" = "api-2tier.mingming.shop"
    "ui" = "ui-2tier.mingming.shop"
  }
}


# ######################
# Output
# ######################
variable "ui-a-tg80" {
  description = "target group of ui(for blue/green)"
}

variable "ui-b-tg80" {
  description = "target group2 of ui(for blue/green)"
}

variable "api-a-tg8080" {
  description = "target group of api(for blue/green)"
}

variable "api-b-tg8080" {
  description = "target group2 of api(for blue/green)"
}


# ######################
# Data
# ######################
variable "alb_id" {
  description = "ming-2t-apne2-prd-alb id"
  type = string
  default = "arn:aws:elasticloadbalancing:ap-northeast-2:144149479695:loadbalancer/app/ming-2t-apne2-prd-alb/2443e864e9e0fee4"
}

variable "acm_arn" {
  description = "acm arn"
  type = string
  default = "arn:aws:acm:ap-northeast-2:144149479695:certificate/efc7a467-526d-4476-b91f-ef69f146c6a6"
}