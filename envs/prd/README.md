<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.10.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.27.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_account"></a> [account](#module\_account) | ../../modules/account | n/a |
| <a name="module_acm"></a> [acm](#module\_acm) | ../../modules/acm | n/a |
| <a name="module_acm_self_signed"></a> [acm\_self\_signed](#module\_acm\_self\_signed) | ../../modules/acmselfsigned | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | ../../modules/alb | n/a |
| <a name="module_alb_blue_http_listener"></a> [alb\_blue\_http\_listener](#module\_alb\_blue\_http\_listener) | ../../modules/albhttplistener | n/a |
| <a name="module_alb_blue_https_listener"></a> [alb\_blue\_https\_listener](#module\_alb\_blue\_https\_listener) | ../../modules/albhttpslistener | n/a |
| <a name="module_alb_blue_tg"></a> [alb\_blue\_tg](#module\_alb\_blue\_tg) | ../../modules/albtargetgroup | n/a |
| <a name="module_alb_green_http_listener"></a> [alb\_green\_http\_listener](#module\_alb\_green\_http\_listener) | ../../modules/albhttplistener | n/a |
| <a name="module_alb_green_https_listener"></a> [alb\_green\_https\_listener](#module\_alb\_green\_https\_listener) | ../../modules/albhttpslistener | n/a |
| <a name="module_alb_green_tg"></a> [alb\_green\_tg](#module\_alb\_green\_tg) | ../../modules/albtargetgroup | n/a |
| <a name="module_alb_sg"></a> [alb\_sg](#module\_alb\_sg) | ../../modules/securitygroup | n/a |
| <a name="module_alb_sg_egress_rule_all"></a> [alb\_sg\_egress\_rule\_all](#module\_alb\_sg\_egress\_rule\_all) | ../../modules/securitygrouprule | n/a |
| <a name="module_alb_sg_ingress_rule_blue_http"></a> [alb\_sg\_ingress\_rule\_blue\_http](#module\_alb\_sg\_ingress\_rule\_blue\_http) | ../../modules/securitygrouprule | n/a |
| <a name="module_alb_sg_ingress_rule_blue_https"></a> [alb\_sg\_ingress\_rule\_blue\_https](#module\_alb\_sg\_ingress\_rule\_blue\_https) | ../../modules/securitygrouprule | n/a |
| <a name="module_alb_sg_ingress_rule_green_http"></a> [alb\_sg\_ingress\_rule\_green\_http](#module\_alb\_sg\_ingress\_rule\_green\_http) | ../../modules/securitygrouprule | n/a |
| <a name="module_alb_sg_ingress_rule_green_https"></a> [alb\_sg\_ingress\_rule\_green\_https](#module\_alb\_sg\_ingress\_rule\_green\_https) | ../../modules/securitygrouprule | n/a |
| <a name="module_backup_common"></a> [backup\_common](#module\_backup\_common) | ../../modules/backupcommon | n/a |
| <a name="module_backup_rds"></a> [backup\_rds](#module\_backup\_rds) | ../../modules/backuprds | n/a |
| <a name="module_codebuild_app"></a> [codebuild\_app](#module\_codebuild\_app) | ../../modules/codebuild | n/a |
| <a name="module_codebuild_app_log_group"></a> [codebuild\_app\_log\_group](#module\_codebuild\_app\_log\_group) | ../../modules/cloudwatchloggroup | n/a |
| <a name="module_codebuild_sg"></a> [codebuild\_sg](#module\_codebuild\_sg) | ../../modules/securitygroup | n/a |
| <a name="module_codebuild_sg_egress_rule_all"></a> [codebuild\_sg\_egress\_rule\_all](#module\_codebuild\_sg\_egress\_rule\_all) | ../../modules/securitygrouprule | n/a |
| <a name="module_codeconnection"></a> [codeconnection](#module\_codeconnection) | ../../modules/codeconnection | n/a |
| <a name="module_codedeploy"></a> [codedeploy](#module\_codedeploy) | ../../modules/codedeploy | n/a |
| <a name="module_codepipeline"></a> [codepipeline](#module\_codepipeline) | ../../modules/codepipeline | n/a |
| <a name="module_docker_start"></a> [docker\_start](#module\_docker\_start) | ../../modules/dockerstart | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ../../modules/ecr | n/a |
| <a name="module_ecr_app_push"></a> [ecr\_app\_push](#module\_ecr\_app\_push) | ../../modules/dockerpush | n/a |
| <a name="module_ecr_login"></a> [ecr\_login](#module\_ecr\_login) | ../../modules/ecrlogin | n/a |
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ../../modules/ecscluster | n/a |
| <a name="module_ecs_service"></a> [ecs\_service](#module\_ecs\_service) | ../../modules/ecsservice | n/a |
| <a name="module_ecs_sg"></a> [ecs\_sg](#module\_ecs\_sg) | ../../modules/securitygroup | n/a |
| <a name="module_ecs_sg_egress_rule_all"></a> [ecs\_sg\_egress\_rule\_all](#module\_ecs\_sg\_egress\_rule\_all) | ../../modules/securitygrouprule | n/a |
| <a name="module_ecs_sg_ingress_rule_http"></a> [ecs\_sg\_ingress\_rule\_http](#module\_ecs\_sg\_ingress\_rule\_http) | ../../modules/securitygrouprule | n/a |
| <a name="module_ecs_task"></a> [ecs\_task](#module\_ecs\_task) | ../../modules/ecstask | n/a |
| <a name="module_elb_service_account"></a> [elb\_service\_account](#module\_elb\_service\_account) | ../../modules/elbserviceaccount | n/a |
| <a name="module_frontend_error_log_group"></a> [frontend\_error\_log\_group](#module\_frontend\_error\_log\_group) | ../../modules/cloudwatchloggroup | n/a |
| <a name="module_iam_backup_backup_policy"></a> [iam\_backup\_backup\_policy](#module\_iam\_backup\_backup\_policy) | ../../modules/iamservierolepolicy | n/a |
| <a name="module_iam_backup_backup_policy_attach"></a> [iam\_backup\_backup\_policy\_attach](#module\_iam\_backup\_backup\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_backup_restores_policy"></a> [iam\_backup\_restores\_policy](#module\_iam\_backup\_restores\_policy) | ../../modules/iamservierolepolicy | n/a |
| <a name="module_iam_backup_restores_policy_attach"></a> [iam\_backup\_restores\_policy\_attach](#module\_iam\_backup\_restores\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_backup_role"></a> [iam\_backup\_role](#module\_iam\_backup\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_codebuild_bucket_policy"></a> [iam\_codebuild\_bucket\_policy](#module\_iam\_codebuild\_bucket\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codebuild_ecr_policy"></a> [iam\_codebuild\_ecr\_policy](#module\_iam\_codebuild\_ecr\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codebuild_logs_policy"></a> [iam\_codebuild\_logs\_policy](#module\_iam\_codebuild\_logs\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codebuild_role"></a> [iam\_codebuild\_role](#module\_iam\_codebuild\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_codebuild_role_bucket_policy_attach"></a> [iam\_codebuild\_role\_bucket\_policy\_attach](#module\_iam\_codebuild\_role\_bucket\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codebuild_role_ecr_policy_attach"></a> [iam\_codebuild\_role\_ecr\_policy\_attach](#module\_iam\_codebuild\_role\_ecr\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codebuild_role_logs_policy_attach"></a> [iam\_codebuild\_role\_logs\_policy\_attach](#module\_iam\_codebuild\_role\_logs\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codebuild_role_subnet_policy_attach"></a> [iam\_codebuild\_role\_subnet\_policy\_attach](#module\_iam\_codebuild\_role\_subnet\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codebuild_role_vpc_policy_attach"></a> [iam\_codebuild\_role\_vpc\_policy\_attach](#module\_iam\_codebuild\_role\_vpc\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codebuild_subnet_policy"></a> [iam\_codebuild\_subnet\_policy](#module\_iam\_codebuild\_subnet\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codebuild_vpc_policy"></a> [iam\_codebuild\_vpc\_policy](#module\_iam\_codebuild\_vpc\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codedeploy_policy"></a> [iam\_codedeploy\_policy](#module\_iam\_codedeploy\_policy) | ../../modules/iamservierolepolicy | n/a |
| <a name="module_iam_codedeploy_role"></a> [iam\_codedeploy\_role](#module\_iam\_codedeploy\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_codedeploy_role_policy_attach"></a> [iam\_codedeploy\_role\_policy\_attach](#module\_iam\_codedeploy\_role\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_application_policy"></a> [iam\_codepipeline\_application\_policy](#module\_iam\_codepipeline\_application\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_application_policy_attach"></a> [iam\_codepipeline\_application\_policy\_attach](#module\_iam\_codepipeline\_application\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_bucket_policy"></a> [iam\_codepipeline\_bucket\_policy](#module\_iam\_codepipeline\_bucket\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_build_policy"></a> [iam\_codepipeline\_build\_policy](#module\_iam\_codepipeline\_build\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_build_policy_attach"></a> [iam\_codepipeline\_build\_policy\_attach](#module\_iam\_codepipeline\_build\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_connection_policy"></a> [iam\_codepipeline\_connection\_policy](#module\_iam\_codepipeline\_connection\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_connection_policy_attach"></a> [iam\_codepipeline\_connection\_policy\_attach](#module\_iam\_codepipeline\_connection\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_deploy_config_policy"></a> [iam\_codepipeline\_deploy\_config\_policy](#module\_iam\_codepipeline\_deploy\_config\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_deploy_config_policy_attach"></a> [iam\_codepipeline\_deploy\_config\_policy\_attach](#module\_iam\_codepipeline\_deploy\_config\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_deploy_deployment_policy"></a> [iam\_codepipeline\_deploy\_deployment\_policy](#module\_iam\_codepipeline\_deploy\_deployment\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_deploy_deployment_policy_attach"></a> [iam\_codepipeline\_deploy\_deployment\_policy\_attach](#module\_iam\_codepipeline\_deploy\_deployment\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_ecs_service_policy"></a> [iam\_codepipeline\_ecs\_service\_policy](#module\_iam\_codepipeline\_ecs\_service\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_ecs_service_policy_attach"></a> [iam\_codepipeline\_ecs\_service\_policy\_attach](#module\_iam\_codepipeline\_ecs\_service\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_ecs_tag_policy"></a> [iam\_codepipeline\_ecs\_tag\_policy](#module\_iam\_codepipeline\_ecs\_tag\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_ecs_tag_policy_attach"></a> [iam\_codepipeline\_ecs\_tag\_policy\_attach](#module\_iam\_codepipeline\_ecs\_tag\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_ecs_task_policy"></a> [iam\_codepipeline\_ecs\_task\_policy](#module\_iam\_codepipeline\_ecs\_task\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_ecs_task_policy_attach"></a> [iam\_codepipeline\_ecs\_task\_policy\_attach](#module\_iam\_codepipeline\_ecs\_task\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_object_policy"></a> [iam\_codepipeline\_object\_policy](#module\_iam\_codepipeline\_object\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_object_policy_attach"></a> [iam\_codepipeline\_object\_policy\_attach](#module\_iam\_codepipeline\_object\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_passrole_policy"></a> [iam\_codepipeline\_passrole\_policy](#module\_iam\_codepipeline\_passrole\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_codepipeline_passrole_policy_attach"></a> [iam\_codepipeline\_passrole\_policy\_attach](#module\_iam\_codepipeline\_passrole\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_codepipeline_role"></a> [iam\_codepipeline\_role](#module\_iam\_codepipeline\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_codepipeline_role_bucket_policy_attach"></a> [iam\_codepipeline\_role\_bucket\_policy\_attach](#module\_iam\_codepipeline\_role\_bucket\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_ecs_exec_policy"></a> [iam\_ecs\_exec\_policy](#module\_iam\_ecs\_exec\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_ecs_infra_policy"></a> [iam\_ecs\_infra\_policy](#module\_iam\_ecs\_infra\_policy) | ../../modules/iamservierolepolicy | n/a |
| <a name="module_iam_ecs_infra_role"></a> [iam\_ecs\_infra\_role](#module\_iam\_ecs\_infra\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_ecs_infra_role_policy_attach"></a> [iam\_ecs\_infra\_role\_policy\_attach](#module\_iam\_ecs\_infra\_role\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_ecs_s3_policy"></a> [iam\_ecs\_s3\_policy](#module\_iam\_ecs\_s3\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_ecs_secret_policy"></a> [iam\_ecs\_secret\_policy](#module\_iam\_ecs\_secret\_policy) | ../../modules/iampolicy | n/a |
| <a name="module_iam_ecs_task_exec_policy"></a> [iam\_ecs\_task\_exec\_policy](#module\_iam\_ecs\_task\_exec\_policy) | ../../modules/iamservierolepolicy | n/a |
| <a name="module_iam_ecs_task_exec_role"></a> [iam\_ecs\_task\_exec\_role](#module\_iam\_ecs\_task\_exec\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_ecs_task_exec_role_policy_attach"></a> [iam\_ecs\_task\_exec\_role\_policy\_attach](#module\_iam\_ecs\_task\_exec\_role\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_ecs_task_exec_role_secret_policy_attach"></a> [iam\_ecs\_task\_exec\_role\_secret\_policy\_attach](#module\_iam\_ecs\_task\_exec\_role\_secret\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_ecs_task_role"></a> [iam\_ecs\_task\_role](#module\_iam\_ecs\_task\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_ecs_task_role_exec_policy_attach"></a> [iam\_ecs\_task\_role\_exec\_policy\_attach](#module\_iam\_ecs\_task\_role\_exec\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_ecs_task_role_s3_policy_attach"></a> [iam\_ecs\_task\_role\_s3\_policy\_attach](#module\_iam\_ecs\_task\_role\_s3\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_ecs_task_role_secret_policy_attach"></a> [iam\_ecs\_task\_role\_secret\_policy\_attach](#module\_iam\_ecs\_task\_role\_secret\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_iam_rds_policy"></a> [iam\_rds\_policy](#module\_iam\_rds\_policy) | ../../modules/iamservierolepolicy | n/a |
| <a name="module_iam_rds_role"></a> [iam\_rds\_role](#module\_iam\_rds\_role) | ../../modules/iamrole | n/a |
| <a name="module_iam_rds_role_policy_attach"></a> [iam\_rds\_role\_policy\_attach](#module\_iam\_rds\_role\_policy\_attach) | ../../modules/iamrolepolicyattach | n/a |
| <a name="module_internetgateway"></a> [internetgateway](#module\_internetgateway) | ../../modules/internetgateway | n/a |
| <a name="module_isolated_1a_subnet"></a> [isolated\_1a\_subnet](#module\_isolated\_1a\_subnet) | ../../modules/subnet | n/a |
| <a name="module_isolated_1c_subnet"></a> [isolated\_1c\_subnet](#module\_isolated\_1c\_subnet) | ../../modules/subnet | n/a |
| <a name="module_isolated_networkacl"></a> [isolated\_networkacl](#module\_isolated\_networkacl) | ../../modules/networkacl | n/a |
| <a name="module_isolated_routetable"></a> [isolated\_routetable](#module\_isolated\_routetable) | ../../modules/routetable | n/a |
| <a name="module_private_1a_routetable"></a> [private\_1a\_routetable](#module\_private\_1a\_routetable) | ../../modules/routetable | n/a |
| <a name="module_private_1a_subnet"></a> [private\_1a\_subnet](#module\_private\_1a\_subnet) | ../../modules/subnet | n/a |
| <a name="module_private_1c_routetable"></a> [private\_1c\_routetable](#module\_private\_1c\_routetable) | ../../modules/routetable | n/a |
| <a name="module_private_1c_subnet"></a> [private\_1c\_subnet](#module\_private\_1c\_subnet) | ../../modules/subnet | n/a |
| <a name="module_private_networkacl"></a> [private\_networkacl](#module\_private\_networkacl) | ../../modules/networkacl | n/a |
| <a name="module_public_1a_natgateway"></a> [public\_1a\_natgateway](#module\_public\_1a\_natgateway) | ../../modules/natgateway | n/a |
| <a name="module_public_1a_subnet"></a> [public\_1a\_subnet](#module\_public\_1a\_subnet) | ../../modules/subnet | n/a |
| <a name="module_public_1c_natgateway"></a> [public\_1c\_natgateway](#module\_public\_1c\_natgateway) | ../../modules/natgateway | n/a |
| <a name="module_public_1c_subnet"></a> [public\_1c\_subnet](#module\_public\_1c\_subnet) | ../../modules/subnet | n/a |
| <a name="module_public_networkacl"></a> [public\_networkacl](#module\_public\_networkacl) | ../../modules/networkacl | n/a |
| <a name="module_public_routetable"></a> [public\_routetable](#module\_public\_routetable) | ../../modules/routetable | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | ../../modules/rds | n/a |
| <a name="module_rds_sg"></a> [rds\_sg](#module\_rds\_sg) | ../../modules/securitygroup | n/a |
| <a name="module_rds_sg_egress_rule_all"></a> [rds\_sg\_egress\_rule\_all](#module\_rds\_sg\_egress\_rule\_all) | ../../modules/securitygrouprule | n/a |
| <a name="module_rds_sg_ingress_rule_rds"></a> [rds\_sg\_ingress\_rule\_rds](#module\_rds\_sg\_ingress\_rule\_rds) | ../../modules/securitygrouprule | n/a |
| <a name="module_route53_record"></a> [route53\_record](#module\_route53\_record) | ../../modules/route53record | n/a |
| <a name="module_s3_alb_log_bucket"></a> [s3\_alb\_log\_bucket](#module\_s3\_alb\_log\_bucket) | ../../modules/s3logbucket | n/a |
| <a name="module_s3_alb_log_bucket_policy"></a> [s3\_alb\_log\_bucket\_policy](#module\_s3\_alb\_log\_bucket\_policy) | ../../modules/s3bucketpolicy | n/a |
| <a name="module_s3_artifact_bucket"></a> [s3\_artifact\_bucket](#module\_s3\_artifact\_bucket) | ../../modules/s3artifactbucket | n/a |
| <a name="module_s3_vpc_log_bucket"></a> [s3\_vpc\_log\_bucket](#module\_s3\_vpc\_log\_bucket) | ../../modules/s3logbucket | n/a |
| <a name="module_s3_waf_log_bucket"></a> [s3\_waf\_log\_bucket](#module\_s3\_waf\_log\_bucket) | ../../modules/s3logbucket | n/a |
| <a name="module_ssm_session_log_bucket"></a> [ssm\_session\_log\_bucket](#module\_ssm\_session\_log\_bucket) | ../../modules/s3logbucket | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |
| <a name="module_vpce_ecr_api"></a> [vpce\_ecr\_api](#module\_vpce\_ecr\_api) | ../../modules/vpcendpoint | n/a |
| <a name="module_vpce_ecr_dkr"></a> [vpce\_ecr\_dkr](#module\_vpce\_ecr\_dkr) | ../../modules/vpcendpoint | n/a |
| <a name="module_vpce_s3"></a> [vpce\_s3](#module\_vpce\_s3) | ../../modules/vpcendpoint | n/a |
| <a name="module_vpce_sg"></a> [vpce\_sg](#module\_vpce\_sg) | ../../modules/securitygroup | n/a |
| <a name="module_vpce_sg_egress_rule_all"></a> [vpce\_sg\_egress\_rule\_all](#module\_vpce\_sg\_egress\_rule\_all) | ../../modules/securitygrouprule | n/a |
| <a name="module_vpce_sg_ingress_rule_https"></a> [vpce\_sg\_ingress\_rule\_https](#module\_vpce\_sg\_ingress\_rule\_https) | ../../modules/securitygrouprule | n/a |
| <a name="module_waf"></a> [waf](#module\_waf) | ../../modules/waf | n/a |
| <a name="module_waf_association"></a> [waf\_association](#module\_waf\_association) | ../../modules/wafassociation | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_region.region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_log_prefix"></a> [access\_log\_prefix](#input\_access\_log\_prefix) | ALBアクセスログのプレフィックス | `string` | `"alb"` | no |
| <a name="input_alb_target_type_ec2"></a> [alb\_target\_type\_ec2](#input\_alb\_target\_type\_ec2) | ALBターゲットタイプ（EC2インスタンス用） | `string` | `"instance"` | no |
| <a name="input_alb_target_type_ecs"></a> [alb\_target\_type\_ecs](#input\_alb\_target\_type\_ecs) | ALBターゲットタイプ（ECS用） | `string` | `"ip"` | no |
| <a name="input_alb_tg_rsrc_type_enduser"></a> [alb\_tg\_rsrc\_type\_enduser](#input\_alb\_tg\_rsrc\_type\_enduser) | ALBターゲットグループリソースタイプ（エンドユーザー用） | `string` | `"enduser"` | no |
| <a name="input_allow_latest_tag"></a> [allow\_latest\_tag](#input\_allow\_latest\_tag) | イメージへのlatestタグ付けを許可するかどうか | `bool` | `true` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | 使用するAMIのID | `string` | `"ami-02e5504ea463e3f34"` | no |
| <a name="input_app_container_name"></a> [app\_container\_name](#input\_app\_container\_name) | アプリケーションコンテナ名 | `string` | `"web_server"` | no |
| <a name="input_app_container_port"></a> [app\_container\_port](#input\_app\_container\_port) | アプリケーションコンテナのポート番号 | `number` | `3000` | no |
| <a name="input_app_image_name"></a> [app\_image\_name](#input\_app\_image\_name) | アプリケーションイメージ名 | `string` | `"nextjs"` | no |
| <a name="input_app_image_tag"></a> [app\_image\_tag](#input\_app\_image\_tag) | アプリケーションイメージタグ | `string` | `"latest"` | no |
| <a name="input_availability_zone_1a"></a> [availability\_zone\_1a](#input\_availability\_zone\_1a) | 使用するアベイラビリティゾーン1a | `string` | `"ap-northeast-1a"` | no |
| <a name="input_availability_zone_1c"></a> [availability\_zone\_1c](#input\_availability\_zone\_1c) | 使用するアベイラビリティゾーン1c | `string` | `"ap-northeast-1c"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWSのリージョン。デフォルトは東京リージョン | `string` | `"ap-northeast-1"` | no |
| <a name="input_az_short_name_1a"></a> [az\_short\_name\_1a](#input\_az\_short\_name\_1a) | アベイラビリティゾーン1aの短縮名 | `string` | `"1a"` | no |
| <a name="input_az_short_name_1c"></a> [az\_short\_name\_1c](#input\_az\_short\_name\_1c) | アベイラビリティゾーン1cの短縮名 | `string` | `"1c"` | no |
| <a name="input_backup_delete_after_days"></a> [backup\_delete\_after\_days](#input\_backup\_delete\_after\_days) | バックアップの保持期間（日数） | `number` | `7` | no |
| <a name="input_backup_schedule_expression"></a> [backup\_schedule\_expression](#input\_backup\_schedule\_expression) | バックアップのスケジュール式（cron形式） | `string` | `"cron(0 16 * * ? *)"` | no |
| <a name="input_backup_tag_key"></a> [backup\_tag\_key](#input\_backup\_tag\_key) | バックアップ対象を識別するためのタグキー | `string` | `"Backup"` | no |
| <a name="input_blue_http_port"></a> [blue\_http\_port](#input\_blue\_http\_port) | BlueターゲットグループのHTTPポート番号 | `number` | `80` | no |
| <a name="input_blue_https_port"></a> [blue\_https\_port](#input\_blue\_https\_port) | BlueターゲットグループのHTTPSポート番号 | `number` | `443` | no |
| <a name="input_code_connection_name"></a> [code\_connection\_name](#input\_code\_connection\_name) | CodePipelineのCode Connection名前 | `string` | n/a | yes |
| <a name="input_codebuild_compute_type"></a> [codebuild\_compute\_type](#input\_codebuild\_compute\_type) | CodeBuildのコンピュートタイプ | `string` | `"BUILD_GENERAL1_SMALL"` | no |
| <a name="input_codebuild_image"></a> [codebuild\_image](#input\_codebuild\_image) | CodeBuildのイメージ | `string` | `"aws/codebuild/amazonlinux-x86_64-standard:5.0"` | no |
| <a name="input_db_allocated_storage"></a> [db\_allocated\_storage](#input\_db\_allocated\_storage) | RDSの割り当てストレージサイズ（GB） | `number` | `100` | no |
| <a name="input_db_apply_immediately"></a> [db\_apply\_immediately](#input\_db\_apply\_immediately) | RDSの変更を即時適用するかどうか | `bool` | `true` | no |
| <a name="input_db_auto_minor_version_upgrade"></a> [db\_auto\_minor\_version\_upgrade](#input\_db\_auto\_minor\_version\_upgrade) | RDSの自動マイナーバージョンアップグレードを有効にするかどうか | `bool` | `false` | no |
| <a name="input_db_backup_retention_period"></a> [db\_backup\_retention\_period](#input\_db\_backup\_retention\_period) | RDSの自動バックアップ保持期間（日数） | `number` | `0` | no |
| <a name="input_db_backup_window"></a> [db\_backup\_window](#input\_db\_backup\_window) | RDSの自動バックアップウィンドウ | `string` | `"15:00-15:30"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | RDSインスタンスクラス | `string` | `"db.m7g.large"` | no |
| <a name="input_db_maintenance_window"></a> [db\_maintenance\_window](#input\_db\_maintenance\_window) | RDSのメンテナンスウィンドウ | `string` | `"Sat:16:00-Sat:16:30"` | no |
| <a name="input_db_max_allocated_storage"></a> [db\_max\_allocated\_storage](#input\_db\_max\_allocated\_storage) | RDSの最大割り当てストレージサイズ（GB） | `number` | `1000` | no |
| <a name="input_db_monitoring_interval"></a> [db\_monitoring\_interval](#input\_db\_monitoring\_interval) | RDSの拡張モニタリングの間隔（秒） | `number` | `60` | no |
| <a name="input_db_performance_insights_enabled"></a> [db\_performance\_insights\_enabled](#input\_db\_performance\_insights\_enabled) | RDSのパフォーマンスインサイトを有効にするかどうか | `bool` | `true` | no |
| <a name="input_db_performance_insights_retention_period"></a> [db\_performance\_insights\_retention\_period](#input\_db\_performance\_insights\_retention\_period) | RDSのパフォーマンスインサイトの保持期間（日数） | `number` | `7` | no |
| <a name="input_db_root_name"></a> [db\_root\_name](#input\_db\_root\_name) | RDSの管理者ユーザー名 | `string` | `"administrator"` | no |
| <a name="input_db_secret_rotate"></a> [db\_secret\_rotate](#input\_db\_secret\_rotate) | RDSのシークレットローテーションを有効にするかどうか | `bool` | `false` | no |
| <a name="input_db_skip_final_snapshot"></a> [db\_skip\_final\_snapshot](#input\_db\_skip\_final\_snapshot) | RDSの削除時に最終スナップショットを作成しないかどうか | `bool` | `true` | no |
| <a name="input_db_storage_encrypted"></a> [db\_storage\_encrypted](#input\_db\_storage\_encrypted) | RDSのストレージ暗号化を有効にするかどうか | `bool` | `true` | no |
| <a name="input_db_storage_type"></a> [db\_storage\_type](#input\_db\_storage\_type) | RDSのストレージタイプ | `string` | `"gp3"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | リソースの削除保護を有効にするかどうか | `bool` | `true` | no |
| <a name="input_deployment_config_name"></a> [deployment\_config\_name](#input\_deployment\_config\_name) | CodeDeployのデプロイ設定名 | `string` | `"CodeDeployDefault.ECSAllAtOnce"` | no |
| <a name="input_deployment_strategy"></a> [deployment\_strategy](#input\_deployment\_strategy) | デプロイ戦略 (null: CI/CDなし, ecs\_rolling\_update: ECSローリングアップデート, ecs\_blue\_green\_deployment: ECSネイティブのブルーグリーン, codedeploy\_blue\_green\_deployment: CodeDeployブルーグリーン) | `string` | `null` | no |
| <a name="input_desktop_app_name"></a> [desktop\_app\_name](#input\_desktop\_app\_name) | ローカル開発で使用するデスクトップアプリケーション名（null: 使用しない, docker\_desktop: Docker Desktop, rancher\_desktop: Rancher Desktop） | `string` | `null` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | ECSサービスの所望数 | `number` | `2` | no |
| <a name="input_ecs_task_cpu"></a> [ecs\_task\_cpu](#input\_ecs\_task\_cpu) | ECSタスクのCPU | `number` | `2048` | no |
| <a name="input_ecs_task_memory"></a> [ecs\_task\_memory](#input\_ecs\_task\_memory) | ECSタスクのメモリ | `number` | `4096` | no |
| <a name="input_enable_approval_stage"></a> [enable\_approval\_stage](#input\_enable\_approval\_stage) | CodePipelineの承認ステージを有効にするかどうか | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | 環境名（prd: 本番環境, stg: ステージング環境, dev: 開発環境） | `string` | `"prd"` | no |
| <a name="input_flow_log_file_format_text"></a> [flow\_log\_file\_format\_text](#input\_flow\_log\_file\_format\_text) | VPCフローログのテキスト形式 | `string` | `"plain-text"` | no |
| <a name="input_flow_log_file_parquet"></a> [flow\_log\_file\_parquet](#input\_flow\_log\_file\_parquet) | VPCフローログのParquet形式 | `string` | `"parquet"` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | リソースを強制的に削除するかどうか | `bool` | `false` | no |
| <a name="input_github_appspec_file_path"></a> [github\_appspec\_file\_path](#input\_github\_appspec\_file\_path) | GitHubリポジトリ内のappspecファイルのパス | `string` | `"appspec.yml"` | no |
| <a name="input_github_branch_name"></a> [github\_branch\_name](#input\_github\_branch\_name) | GitHubのブランチ名 | `string` | `"main"` | no |
| <a name="input_github_docker_file_path"></a> [github\_docker\_file\_path](#input\_github\_docker\_file\_path) | GitHubリポジトリ内のDockerfileのパス | `string` | `"Dockerfile"` | no |
| <a name="input_github_repository_name"></a> [github\_repository\_name](#input\_github\_repository\_name) | GitHubのリポジトリ名 | `string` | n/a | yes |
| <a name="input_github_repository_owner"></a> [github\_repository\_owner](#input\_github\_repository\_owner) | GitHubのリポジトリ所有者 | `string` | n/a | yes |
| <a name="input_github_taskdef_file_path"></a> [github\_taskdef\_file\_path](#input\_github\_taskdef\_file\_path) | GitHubリポジトリ内のtaskdefファイルのパス | `string` | `"taskdef.json"` | no |
| <a name="input_green_http_port"></a> [green\_http\_port](#input\_green\_http\_port) | GreenターゲットグループのHTTPポート番号 | `number` | `8080` | no |
| <a name="input_green_https_port"></a> [green\_https\_port](#input\_green\_https\_port) | GreenターゲットグループのHTTPSポート番号 | `number` | `8443` | no |
| <a name="input_has_public_ip_to_computer"></a> [has\_public\_ip\_to\_computer](#input\_has\_public\_ip\_to\_computer) | EC2インスタンスにパブリックIPを割り当てるかどうか | `bool` | `false` | no |
| <a name="input_has_public_ip_to_container"></a> [has\_public\_ip\_to\_container](#input\_has\_public\_ip\_to\_container) | コンテナにパブリックIPを割り当てるかどうか | `bool` | `false` | no |
| <a name="input_isolated_subnet_1a_cidr_block"></a> [isolated\_subnet\_1a\_cidr\_block](#input\_isolated\_subnet\_1a\_cidr\_block) | 分離サブネット1aのCIDRブロック | `string` | `"10.0.4.0/24"` | no |
| <a name="input_isolated_subnet_1c_cidr_block"></a> [isolated\_subnet\_1c\_cidr\_block](#input\_isolated\_subnet\_1c\_cidr\_block) | 分離サブネット1cのCIDRブロック | `string` | `"10.0.5.0/24"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | マルチAZ配置を有効にするかどうか | `bool` | `true` | no |
| <a name="input_naked_domain"></a> [naked\_domain](#input\_naked\_domain) | ベースドメイン名 | `string` | `null` | no |
| <a name="input_network_rsrc_type_isolated"></a> [network\_rsrc\_type\_isolated](#input\_network\_rsrc\_type\_isolated) | 分離ネットワークリソースタイプの識別子 | `string` | `"isolated"` | no |
| <a name="input_network_rsrc_type_private"></a> [network\_rsrc\_type\_private](#input\_network\_rsrc\_type\_private) | プライベートネットワークリソースタイプの識別子 | `string` | `"private"` | no |
| <a name="input_network_rsrc_type_public"></a> [network\_rsrc\_type\_public](#input\_network\_rsrc\_type\_public) | パブリックネットワークリソースタイプの識別子 | `string` | `"public"` | no |
| <a name="input_object_expiration_days"></a> [object\_expiration\_days](#input\_object\_expiration\_days) | S3オブジェクトの有効期限（日数） | `number` | `366` | no |
| <a name="input_operating_system"></a> [operating\_system](#input\_operating\_system) | 使用するオペレーティングシステム | `string` | `"AMAZON_LINUX_2023"` | no |
| <a name="input_policy_rsrc_type_backup"></a> [policy\_rsrc\_type\_backup](#input\_policy\_rsrc\_type\_backup) | バックアップポリシーリソースタイプの識別子 | `string` | `"backup"` | no |
| <a name="input_policy_rsrc_type_secret"></a> [policy\_rsrc\_type\_secret](#input\_policy\_rsrc\_type\_secret) | Secrets Managerポリシーリソースタイプの識別子 | `string` | `"secret"` | no |
| <a name="input_policy_rsrc_type_ssm"></a> [policy\_rsrc\_type\_ssm](#input\_policy\_rsrc\_type\_ssm) | SSMポリシーリソースタイプの識別子 | `string` | `"ssm"` | no |
| <a name="input_private_subnet_1a_cidr_block"></a> [private\_subnet\_1a\_cidr\_block](#input\_private\_subnet\_1a\_cidr\_block) | プライベートサブネット1aのCIDRブロック | `string` | `"10.0.2.0/24"` | no |
| <a name="input_private_subnet_1c_cidr_block"></a> [private\_subnet\_1c\_cidr\_block](#input\_private\_subnet\_1c\_cidr\_block) | プライベートサブネット1cのCIDRブロック | `string` | `"10.0.3.0/24"` | no |
| <a name="input_project"></a> [project](#input\_project) | プロジェクト名 | `string` | `"management"` | no |
| <a name="input_public_subnet_1a_cidr_block"></a> [public\_subnet\_1a\_cidr\_block](#input\_public\_subnet\_1a\_cidr\_block) | パブリックサブネット1aのCIDRブロック | `string` | `"10.0.0.0/24"` | no |
| <a name="input_public_subnet_1c_cidr_block"></a> [public\_subnet\_1c\_cidr\_block](#input\_public\_subnet\_1c\_cidr\_block) | パブリックサブネット1cのCIDRブロック | `string` | `"10.0.1.0/24"` | no |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | RDSのデータベースエンジン | `string` | `"postgres"` | no |
| <a name="input_rds_engine_major_version"></a> [rds\_engine\_major\_version](#input\_rds\_engine\_major\_version) | RDSのデータベースエンジンのメジャーバージョン | `string` | `"17"` | no |
| <a name="input_rds_engine_minor_version"></a> [rds\_engine\_minor\_version](#input\_rds\_engine\_minor\_version) | RDSのデータベースエンジンのマイナーバージョン | `string` | `"17.2"` | no |
| <a name="input_rds_port"></a> [rds\_port](#input\_rds\_port) | RDSのポート番号 | `number` | `5432` | no |
| <a name="input_s3_rsrc_type_alb"></a> [s3\_rsrc\_type\_alb](#input\_s3\_rsrc\_type\_alb) | ALB用S3バケットリソースタイプの識別子 | `string` | `"alb"` | no |
| <a name="input_s3_rsrc_type_ssm"></a> [s3\_rsrc\_type\_ssm](#input\_s3\_rsrc\_type\_ssm) | SSM用S3バケットリソースタイプの識別子 | `string` | `"ssm"` | no |
| <a name="input_s3_rsrc_type_vpc"></a> [s3\_rsrc\_type\_vpc](#input\_s3\_rsrc\_type\_vpc) | VPC用S3バケットリソースタイプの識別子 | `string` | `"vpc"` | no |
| <a name="input_s3_rsrc_type_waf"></a> [s3\_rsrc\_type\_waf](#input\_s3\_rsrc\_type\_waf) | WAF用S3バケットリソースタイプの識別子 | `string` | `"waf"` | no |
| <a name="input_service_rsrc_type_alb"></a> [service\_rsrc\_type\_alb](#input\_service\_rsrc\_type\_alb) | ALBリソースタイプの識別子 | `string` | `"alb"` | no |
| <a name="input_service_rsrc_type_backup"></a> [service\_rsrc\_type\_backup](#input\_service\_rsrc\_type\_backup) | バックアップリソースタイプの識別子 | `string` | `"backup"` | no |
| <a name="input_service_rsrc_type_build"></a> [service\_rsrc\_type\_build](#input\_service\_rsrc\_type\_build) | ビルドリソースタイプの識別子 | `string` | `"build"` | no |
| <a name="input_service_rsrc_type_deploy"></a> [service\_rsrc\_type\_deploy](#input\_service\_rsrc\_type\_deploy) | デプロイリソースタイプの識別子 | `string` | `"deploy"` | no |
| <a name="input_service_rsrc_type_ec2"></a> [service\_rsrc\_type\_ec2](#input\_service\_rsrc\_type\_ec2) | EC2リソースタイプの識別子 | `string` | `"ec2"` | no |
| <a name="input_service_rsrc_type_ecs"></a> [service\_rsrc\_type\_ecs](#input\_service\_rsrc\_type\_ecs) | ECSリソースタイプの識別子 | `string` | `"ecs"` | no |
| <a name="input_service_rsrc_type_patch"></a> [service\_rsrc\_type\_patch](#input\_service\_rsrc\_type\_patch) | パッチ管理リソースタイプの識別子 | `string` | `"patch"` | no |
| <a name="input_service_rsrc_type_pipeline"></a> [service\_rsrc\_type\_pipeline](#input\_service\_rsrc\_type\_pipeline) | パイプラインリソースタイプの識別子 | `string` | `"pipeline"` | no |
| <a name="input_service_rsrc_type_rds"></a> [service\_rsrc\_type\_rds](#input\_service\_rsrc\_type\_rds) | RDSリソースタイプの識別子 | `string` | `"rds"` | no |
| <a name="input_sub_domain"></a> [sub\_domain](#input\_sub\_domain) | サブドメイン名 | `string` | `"test"` | no |
| <a name="input_system"></a> [system](#input\_system) | システム名 | `string` | `"sample"` | no |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | S3バケットのバージョニングを有効にするかどうか | `bool` | `false` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPCのCIDRブロック | `string` | `"10.0.0.0/16"` | no |
| <a name="input_waf_default_action_block_mode"></a> [waf\_default\_action\_block\_mode](#input\_waf\_default\_action\_block\_mode) | WAFのデフォルトアクションをブロックにするかどうか | `bool` | `true` | no |
| <a name="input_waf_ip_list"></a> [waf\_ip\_list](#input\_waf\_ip\_list) | WAFのIPアドレス | `list(string)` | <pre>[<br/>  "0.0.0.0/1",<br/>  "128.0.0.0/1"<br/>]</pre> | no |
| <a name="input_waf_ip_rule_allow_mode"></a> [waf\_ip\_rule\_allow\_mode](#input\_waf\_ip\_rule\_allow\_mode) | WAFのIPアドレスルールをアローにするかどうか | `bool` | `true` | no |
| <a name="input_waf_managed_rule_block_mode"></a> [waf\_managed\_rule\_block\_mode](#input\_waf\_managed\_rule\_block\_mode) | WAFのマネージドルールをブロックにするかどうか | `bool` | `false` | no |
| <a name="input_waf_rsrc_type_alb"></a> [waf\_rsrc\_type\_alb](#input\_waf\_rsrc\_type\_alb) | WAFリソースタイプ（ALB用） | `string` | `"alb"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_domain"></a> [access\_domain](#output\_access\_domain) | アクセスドメイン（ネイキッドドメインが設定されていない場合はALBのDNS名、設定されている場合はカスタムドメインを表示） |
<!-- END_TF_DOCS -->
