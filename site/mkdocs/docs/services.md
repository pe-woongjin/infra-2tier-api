## infra-2tier-services Services
---
services는 `api`, `ui`로 구성되어 있습니다.

---
#### 1. API
>app-backend-springboot application을 위한 인프라입니다.  
>application을 위한 resource는 다음과 같습니다.
>
##### 1.1 Security Group
```console
resource "aws_security_group" "api-sg" {            -- Security Group resource 설정
    vpc_id  = var.vpc_id                            -- VPC 설정

    ingress {                                       -- Inbound rule 설정
        ...
    }

    egress {                                        -- Outbound rule 설정
        ...
    }
}
```
>
##### 1.2 Target Group
```console
resource "aws_alb_target_group" "api-a-tg8080" {    -- Target Group resource 설정
    port        = 8080                              -- 포트 설정
    protocol    = "HTTP"                            -- protocol 설정
    target_type = "instance"                        -- 타겟 그룹의 타입 선택(instance, ip, lambda)
    vpc_id      = var.vpc_id                        -- VPC 설정

    health_check {
        healthy_threshold   = 2                     -- 연속적 상태 검사 성공 횟수(2-10)
        unhealthy_threshold = 2                     -- 연속적 상태 검사 실패 횟수(2~10)
        interval            = 10                    -- 상태 검사 사이의 대략적인 시간
        macher              = "200"                 -- 응답 성공 HTTP 코드(200~299)
        path                = "/health"             -- 상태 검사의 대상 경로
    }
    ...
}
```
>
##### 1.3 Launch Template
```console
resource "aws_launch_template" "api-lt" {           -- Launch Template resource 설정
    image_id                = var.api_lt.id         -- 기구축된 image id
    instance_type           = var.api_lt.key_name   -- 기구축된 image의 타입
    key_name                = var.api_lt.type       -- 해당 인스턴스를 사용하기 위한 key name
    vpc_security_group_ids  = [ id ]                -- 관련 security group ids

    iam_instance_profile { } -- The IAM Instance Profile to launch the instance with
    ...
}
```
>
##### 1.4 Autoscaling Group
```console
resource "aws_autoscaling_group" "api-a-asg" {      -- Autoscaling Group resource 설정
    launch_template { }                             -- 기구축된 Launch Template 정보

    vpc_zone_identifier = var.api-sn-id             -- 기구축된 subnet ids
    target_group_arns   = [ arn ]                   -- 기구축된 target group arns(autoscaling 대상)
    health_check_type   = "ELB"                     -- health check 방법 설정(EC2, ELB)                     

    min_size            = var.api_lt.min_size       -- instance의 최소 갯수
    max_size            = var.api_lt.max_size       -- instance의 최대 갯수
    ...
}
```
>
##### 1.5 Code Deploy
```console
data "aws_iam_role" "codedeploy_role" {     -- IAM role 설정
    name = var.cd_role_name                 -- 기구축된 role name 설정
}

resource "aws_codedeploy_deployment_group" "api-cd-group-a" {   -- Codedeploy Deployment Group resource 설정
    deployment_config_name  = "CodeDeployDefault.AllAtOnce"     -- 배포 설정
    service_role_arn        = codedeploy-role.arn               -- 배포 role
    autoscaling_groups      = [ id ]                            -- 배포할 Autoscaling Group
    deployment_style { }                                        -- 배포 스타일(in-place, blue/green) 
    ...
}
```
>
>
>
#### 2. UI  
>app-frontend-vue application을 위한 인프라입니다.
>application을 위한 resource는 다음과 같습니다.
>
##### 2.1 Security Group
```console
resource "aws_security_group" "ui-sg" {             -- Security Group resource 설정
    vpc_id  = var.vpc_id                            -- VPC 설정

    ingress {                                       -- Inbound rule 설정
        ...
    }

    egress {                                        -- Outbound rule 설정
        ...
    }
}
```
>
##### 2.2 Target Group
```console
resource "aws_alb_target_group" "ui-a-tg80" {       -- Target Group resource 설정
    port        = 80                                -- 포트 설정
    protocol    = "HTTP"                            -- protocol 설정
    target_type = "instance"                        -- 타겟 그룹의 타입 선택(instance, ip, lambda)
    vpc_id      = var.vpc_id                        -- VPC 설정

    health_check {
        healthy_threshold   = 2                     -- 연속적 상태 검사 성공 횟수(2-10)
        unhealthy_threshold = 2                     -- 연속적 상태 검사 실패 횟수(2~10)
        interval            = 10                    -- 상태 검사 사이의 대략적인 시간
        macher              = "200"                 -- 응답 성공 HTTP 코드(200~299)
        path                = "/"                   -- 상태 검사의 대상 경로
    }
    ...
}
```
>
##### 2.3 Launch Template
```console
resource "aws_launch_template" "ui-lt" {            -- Launch Template resource 설정
    image_id                = var.ui.id             -- 기구축된 image id
    instance_type           = var.ui.key_name       -- 기구축된 image의 타입
    key_name                = var.ui.type           -- 해당 인스턴스를 사용하기 위한 key name
    vpc_security_group_ids  = [ id ]                -- 관련 security group ids

    iam_instance_profile { } -- The IAM Instance Profile to launch the instance with
    ...
}
```
>
##### 2.4 Autoscaling Group
```console
resource "aws_autoscaling_group" "ui-a-asg" {       -- Autoscaling Group resource 설정
    launch_template { }                             -- 기구축된 Launch Template 정보

    vpc_zone_identifier = var.ui-sn-id              -- 기구축된 subnet ids
    target_group_arns   = [ arn ]                   -- 기구축된 target group arns(autoscaling 대상)
    health_check_type   = "ELB"                     -- health check 방법 설정(EC2, ELB)                     

    min_size            = var.ui_lt.min_size        -- instance의 최소 갯수
    max_size            = var.ui_lt.max_size        -- instance의 최대 갯수
    ...
}
```
>
##### 2.5 Code Deploy
```console
data "aws_iam_role" "codedeploy_role" {     -- IAM role 설정
    name = var.cd_role_name                 -- 기구축된 role name 설정
}

resource "aws_codedeploy_deployment_group" "ui-cd-group-a" {    -- Codedeploy Deployment Group resource 설정
    deployment_config_name  = "CodeDeployDefault.AllAtOnce"     -- 배포 설정
    service_role_arn        = codedeploy-role.arn               -- 배포 role
    autoscaling_groups      = [ id ]                            -- 배포할 Autoscaling Group
    deployment_style { }                                        -- 배포 스타일(in-place, blue/green) 
    ...
}
```