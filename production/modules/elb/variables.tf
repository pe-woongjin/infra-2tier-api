# ######################
# Output
# ######################
variable "api-a-tg8080" {
  description = "target group of api for blue/green"
}


# ######################
# Imported data
# ######################
variable "alb_id" {
  type = string
}

variable "acm_arn" {
  type = string
}