# ====================
#
# Modules
#
# ====================

module "account" {
  source = "../../modules/account"
}

module "vpc" {
  source                              = "../../modules/vpc"
  system                              = var.system
  project                             = var.project
  environment                         = var.environment
  vpc_cidr_block                      = var.vpc_cidr_block
  has_flow_log                        = true
  flow_log_bucket_arn                 = module.s3_vpc_log_bucket.bucket_arn
  flow_log_file_format                = var.flow_log_file_format_text
  flow_log_hive_compatible_partitions = true
  flow_log_per_hour_partition         = false
}

module "s3_vpc_log_bucket" {
  source                 = "../../modules/s3logbucket"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.s3_rsrc_type_vpc
  account_id             = module.account.id
  force_destroy          = var.force_destroy
  versioning_enabled     = var.versioning_enabled
  object_expiration_days = var.object_expiration_days
}

module "public_1a_subnet" {
  source                         = "../../modules/subnet"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.network_rsrc_type_public}-${var.az_short_name_1a}"
  subnet_cidr_block              = var.public_subnet_1a_cidr_block
  subnet_map_public_ip_on_launch = true
  subnet_availability_zone       = var.availability_zone_1a
  vpc_id                         = module.vpc.vpc_id
}

module "public_1c_subnet" {
  source                         = "../../modules/subnet"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.network_rsrc_type_public}-${var.az_short_name_1c}"
  subnet_cidr_block              = var.public_subnet_1c_cidr_block
  subnet_map_public_ip_on_launch = true
  subnet_availability_zone       = var.availability_zone_1c
  vpc_id                         = module.vpc.vpc_id
}

module "private_1a_subnet" {
  source                         = "../../modules/subnet"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.network_rsrc_type_private}-${var.az_short_name_1a}"
  subnet_cidr_block              = var.private_subnet_1a_cidr_block
  subnet_map_public_ip_on_launch = false
  subnet_availability_zone       = var.availability_zone_1a
  vpc_id                         = module.vpc.vpc_id
}

module "private_1c_subnet" {
  source                         = "../../modules/subnet"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.network_rsrc_type_private}-${var.az_short_name_1c}"
  subnet_cidr_block              = var.private_subnet_1c_cidr_block
  subnet_map_public_ip_on_launch = false
  subnet_availability_zone       = var.availability_zone_1c
  vpc_id                         = module.vpc.vpc_id
}

module "isolated_1a_subnet" {
  source                         = "../../modules/subnet"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.network_rsrc_type_isolated}-${var.az_short_name_1a}"
  subnet_cidr_block              = var.isolated_subnet_1a_cidr_block
  subnet_map_public_ip_on_launch = false
  subnet_availability_zone       = var.availability_zone_1a
  vpc_id                         = module.vpc.vpc_id
}

module "isolated_1c_subnet" {
  source                         = "../../modules/subnet"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.network_rsrc_type_isolated}-${var.az_short_name_1c}"
  subnet_cidr_block              = var.isolated_subnet_1c_cidr_block
  subnet_map_public_ip_on_launch = false
  subnet_availability_zone       = var.availability_zone_1c
  vpc_id                         = module.vpc.vpc_id
}


module "public_routetable" {
  source        = "../../modules/routetable"
  system        = var.system
  project       = var.project
  environment   = var.environment
  resourcetype  = var.network_rsrc_type_public
  vpc_id        = module.vpc.vpc_id
  has_subnet_1a = true
  has_subnet_1c = true
  subnet_1a_id  = module.public_1a_subnet.subnet_id
  subnet_1c_id  = module.public_1c_subnet.subnet_id
}

module "private_1a_routetable" {
  source        = "../../modules/routetable"
  system        = var.system
  project       = var.project
  environment   = var.environment
  resourcetype  = "${var.network_rsrc_type_private}-${var.az_short_name_1a}"
  vpc_id        = module.vpc.vpc_id
  has_subnet_1a = true
  subnet_1a_id  = module.private_1a_subnet.subnet_id
}

module "private_1c_routetable" {
  source        = "../../modules/routetable"
  system        = var.system
  project       = var.project
  environment   = var.environment
  resourcetype  = "${var.network_rsrc_type_private}-${var.az_short_name_1c}"
  vpc_id        = module.vpc.vpc_id
  has_subnet_1c = true
  subnet_1c_id  = module.private_1c_subnet.subnet_id
}

module "isolated_routetable" {
  source        = "../../modules/routetable"
  system        = var.system
  project       = var.project
  environment   = var.environment
  resourcetype  = var.network_rsrc_type_isolated
  vpc_id        = module.vpc.vpc_id
  has_subnet_1a = true
  has_subnet_1c = true
  subnet_1a_id  = module.isolated_1a_subnet.subnet_id
  subnet_1c_id  = module.isolated_1c_subnet.subnet_id
}

module "internetgateway" {
  source         = "../../modules/internetgateway"
  system         = var.system
  project        = var.project
  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  route_table_id = module.public_routetable.route_table_id
}

module "public_1a_natgateway" {
  source         = "../../modules/natgateway"
  system         = var.system
  project        = var.project
  environment    = var.environment
  resourcetype   = "${var.network_rsrc_type_public}-${var.az_short_name_1a}"
  subnet_id      = module.public_1a_subnet.subnet_id
  igw_id         = module.internetgateway.internet_route_id
  route_table_id = module.private_1a_routetable.route_table_id
}

module "public_1c_natgateway" {
  source         = "../../modules/natgateway"
  system         = var.system
  project        = var.project
  environment    = var.environment
  resourcetype   = "${var.network_rsrc_type_public}-${var.az_short_name_1c}"
  subnet_id      = module.public_1c_subnet.subnet_id
  igw_id         = module.internetgateway.internet_route_id
  route_table_id = module.private_1c_routetable.route_table_id
}

module "vpce_ecr_dkr" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ecr-dkr"
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.vpce_sg.security_group_id]
  private_dns_enabled = true
  is_gateway_endpoint = false
}

module "vpce_ecr_api" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ecr-api"
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.vpce_sg.security_group_id]
  private_dns_enabled = true
  is_gateway_endpoint = false
}

module "vpce_s3" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "s3"
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-northeast-1.s3"
  vpc_endpoint_type   = "Gateway"
  is_gateway_endpoint = true
  route_table_1a_id   = module.private_1a_routetable.route_table_id
  route_table_1c_id   = module.private_1c_routetable.route_table_id
}

module "public_networkacl" {
  source       = "../../modules/networkacl"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.network_rsrc_type_public
  vpc_id       = module.vpc.vpc_id
  subnet_1a_id = module.public_1a_subnet.subnet_id
  subnet_1c_id = module.public_1c_subnet.subnet_id
}

module "private_networkacl" {
  source       = "../../modules/networkacl"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.network_rsrc_type_private
  vpc_id       = module.vpc.vpc_id
  subnet_1a_id = module.private_1a_subnet.subnet_id
  subnet_1c_id = module.private_1c_subnet.subnet_id
}

module "isolated_networkacl" {
  source       = "../../modules/networkacl"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.network_rsrc_type_isolated
  vpc_id       = module.vpc.vpc_id
  subnet_1a_id = module.isolated_1a_subnet.subnet_id
  subnet_1c_id = module.isolated_1c_subnet.subnet_id
}

module "alb_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_alb
  vpc_id       = module.vpc.vpc_id
}

module "ecs_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_ecs
  vpc_id       = module.vpc.vpc_id
}

module "rds_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_rds
  vpc_id       = module.vpc.vpc_id
}

module "codebuild_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_build
  vpc_id       = module.vpc.vpc_id
}


module "vpce_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.s3_rsrc_type_vpc
  vpc_id       = module.vpc.vpc_id
}
module "alb_sg_ingress_rule_blue_http" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = var.blue_http_port
  sg_rule_to_port     = var.blue_http_port
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_sg_ingress_rule_blue_https" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = var.blue_https_port
  sg_rule_to_port     = var.blue_https_port
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_sg_ingress_rule_green_http" {
  count               = var.deployment_strategy != "ecs_rolling_update" ? 1 : 0
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = var.green_http_port
  sg_rule_to_port     = var.green_http_port
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_sg_ingress_rule_green_https" {
  count               = var.deployment_strategy != "ecs_rolling_update" ? 1 : 0
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = var.green_https_port
  sg_rule_to_port     = var.green_https_port
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "ecs_sg_ingress_rule_http" {
  source                           = "../../modules/securitygrouprule"
  system                           = var.system
  project                          = var.project
  environment                      = var.environment
  security_group_id                = module.ecs_sg.security_group_id
  sg_rule_type                     = "ingress"
  sg_rule_protocol                 = "tcp"
  sg_rule_from_port                = var.app_container_port
  sg_rule_to_port                  = var.app_container_port
  sg_rule_source_security_group_id = module.alb_sg.security_group_id
}

module "ecs_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.ecs_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "rds_sg_ingress_rule_rds" {
  source                           = "../../modules/securitygrouprule"
  system                           = var.system
  project                          = var.project
  environment                      = var.environment
  security_group_id                = module.rds_sg.security_group_id
  sg_rule_type                     = "ingress"
  sg_rule_protocol                 = "tcp"
  sg_rule_from_port                = var.rds_port
  sg_rule_to_port                  = var.rds_port
  sg_rule_source_security_group_id = module.ecs_sg.security_group_id
}

module "rds_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.rds_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "codebuild_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.codebuild_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "vpce_sg_ingress_rule_https" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.vpce_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = var.blue_https_port
  sg_rule_to_port     = var.blue_https_port
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "vpce_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.vpce_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "alb" {
  source                 = "../../modules/alb"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  deletion_protection    = var.deletion_protection
  security_group_id      = module.alb_sg.security_group_id
  subnet_1a_id           = module.public_1a_subnet.subnet_id
  subnet_1c_id           = module.public_1c_subnet.subnet_id
  has_access_logs        = true
  access_log_bucket_name = module.s3_alb_log_bucket.bucket_name
  access_log_prefix      = var.access_log_prefix
}


module "alb_blue_http_listener" {
  source            = "../../modules/albhttplistener"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "blue"
  http_port         = var.blue_http_port
  redirect_port     = var.blue_https_port
  load_balancer_arn = module.alb.alb_arn
}

module "alb_blue_https_listener" {
  source                = "../../modules/albhttpslistener"
  system                = var.system
  project               = var.project
  environment           = var.environment
  resourcetype          = "blue"
  https_port            = var.blue_https_port
  load_balancer_arn     = module.alb.alb_arn
  acm_alb_cert_arn      = var.naked_domain == null ? module.acm_self_signed[0].acm_alb_cert_arn : module.acm[0].acm_alb_cert_arn
  acm_alb_cert_valid_id = var.naked_domain == null ? module.acm_self_signed[0].acm_alb_cert_valid_id : module.acm[0].acm_alb_cert_valid_id
}

module "alb_blue_tg" {
  source                    = "../../modules/albtargetgroup"
  system                    = var.system
  project                   = var.project
  environment               = var.environment
  resourcetype              = "blue"
  vpc_id                    = module.vpc.vpc_id
  alb_target_type           = var.alb_target_type_ecs
  alb_lsnr_https_arn        = module.alb_blue_https_listener.listener_arn
  alb_lsnr_rule_priority    = 100
  has_host_header           = true
  alb_lsnr_rule_host_header = var.naked_domain == null ? module.alb.alb_dns_name : "${var.sub_domain}.${var.naked_domain}"
}

module "alb_green_http_listener" {
  count             = var.deployment_strategy != "ecs_rolling_update" ? 1 : 0
  source            = "../../modules/albhttplistener"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "green"
  http_port         = var.green_http_port
  redirect_port     = var.green_https_port
  load_balancer_arn = module.alb.alb_arn
}

module "alb_green_https_listener" {
  count                 = var.deployment_strategy != "ecs_rolling_update" ? 1 : 0
  source                = "../../modules/albhttpslistener"
  system                = var.system
  project               = var.project
  environment           = var.environment
  resourcetype          = "green"
  https_port            = var.green_https_port
  load_balancer_arn     = module.alb.alb_arn
  acm_alb_cert_arn      = var.naked_domain == null ? module.acm_self_signed[0].acm_alb_cert_arn : module.acm[0].acm_alb_cert_arn
  acm_alb_cert_valid_id = var.naked_domain == null ? module.acm_self_signed[0].acm_alb_cert_valid_id : module.acm[0].acm_alb_cert_valid_id
}

module "alb_green_tg" {
  count                     = var.deployment_strategy != "ecs_rolling_update" ? 1 : 0
  source                    = "../../modules/albtargetgroup"
  system                    = var.system
  project                   = var.project
  environment               = var.environment
  resourcetype              = "green"
  vpc_id                    = module.vpc.vpc_id
  alb_target_type           = var.alb_target_type_ecs
  alb_lsnr_https_arn        = module.alb_green_https_listener[0].listener_arn
  alb_lsnr_rule_priority    = 100
  has_host_header           = true
  alb_lsnr_rule_host_header = var.naked_domain == null ? module.alb.alb_dns_name : "${var.sub_domain}.${var.naked_domain}"
}

module "s3_alb_log_bucket" {
  source                 = "../../modules/s3logbucket"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.s3_rsrc_type_alb
  account_id             = module.account.id
  force_destroy          = var.force_destroy
  versioning_enabled     = var.versioning_enabled
  object_expiration_days = var.object_expiration_days
}


module "elb_service_account" {
  source = "../../modules/elbserviceaccount"
}

module "s3_alb_log_bucket_policy" {
  source                      = "../../modules/s3bucketpolicy"
  bucket_name                 = module.s3_alb_log_bucket.bucket_name
  bucket_id                   = module.s3_alb_log_bucket.bucket_id
  account_id                  = module.account.id
  effect                      = "Allow"
  principals_type             = "AWS"
  principals_identifiers_list = ["arn:aws:iam::${module.elb_service_account.elb_service_account_id}:root"]
  action_list                 = ["s3:PutObject"]
  resource_arn_list           = ["arn:aws:s3:::${module.s3_alb_log_bucket.bucket_name}/${var.access_log_prefix}/AWSLogs/${module.account.id}/*"]
}

module "waf" {
  source                         = "../../modules/waf"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.waf_rsrc_type_alb
  waf_default_action_block_mode  = var.waf_default_action_block_mode
  waf_ip_rule_allow_mode         = var.waf_ip_rule_allow_mode
  waf_ip_list                    = var.waf_ip_list
  waf_managed_rule_block_mode    = var.waf_managed_rule_block_mode
  waf_cloudwatch_metrics_enabled = true
  waf_sampled_requests_enabled   = true
  alb_arn                        = module.alb.alb_arn
  has_web_acl_log                = true
  waf_log_bucket_arn             = module.s3_waf_log_bucket.bucket_arn
}

module "waf_association" {
  source          = "../../modules/wafassociation"
  resource_arn    = module.alb.alb_arn
  waf_web_acl_arn = module.waf.web_acl_arn
}

module "s3_waf_log_bucket" {
  source                 = "../../modules/s3logbucket"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.s3_rsrc_type_waf
  account_id             = module.account.id
  force_destroy          = var.force_destroy
  versioning_enabled     = var.versioning_enabled
  object_expiration_days = var.object_expiration_days
}

module "ssm_session_log_bucket" {
  source                 = "../../modules/s3logbucket"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.s3_rsrc_type_ssm
  account_id             = module.account.id
  force_destroy          = var.force_destroy
  versioning_enabled     = var.versioning_enabled
  object_expiration_days = var.object_expiration_days
}


module "ecr" {
  source                       = "../../modules/ecr"
  system                       = var.system
  project                      = var.project
  environment                  = var.environment
  resourcetype                 = var.service_rsrc_type_ecs
  force_destroy                = var.force_destroy
  allow_latest_tag             = var.allow_latest_tag
  image_count_lifecycle_policy = 30
}

module "ecr_login" {
  source             = "../../modules/ecrlogin"
  aws_region         = var.aws_region
  ecr_repository_arn = module.ecr.ecr_repository_arn
  ecr_repository_url = module.ecr.ecr_repository_url
}

# module "rancher_desktop_start" {
#   source = "../../modules/rancherdesktopstart"
# }

module "ecr_app_push" {
  source             = "../../modules/dockerpush"
  aws_region         = var.aws_region
  system             = var.system
  project            = var.project
  environment        = var.environment
  image_name         = var.app_image_name
  image_tag          = var.app_image_tag
  container_name     = var.app_container_name
  dockerfile_path    = "src/${var.app_image_name}/Dockerfile"
  ecr_login_id       = module.ecr_login.ecr_login_id
  ecr_repository_url = module.ecr.ecr_repository_url
}

module "iam_ecs_exec_policy" {
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = var.service_rsrc_type_ecs
  action_list       = ["ssmmessages:CreateControlChannel", "ssmmessages:CreateDataChannel", "ssmmessages:OpenControlChannel", "ssmmessages:OpenDataChannel"]
  resource_arn_list = ["*"]
}

module "iam_ecs_s3_policy" {
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = var.policy_rsrc_type_ssm
  action_list       = ["s3:PutObject", "s3:PutObjectAcl", "s3:GetEncryptionConfiguration"]
  resource_arn_list = [module.ssm_session_log_bucket.bucket_arn, "${module.ssm_session_log_bucket.bucket_arn}/*"]
}

module "iam_ecs_secret_policy" {
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = var.policy_rsrc_type_secret
  action_list       = ["secretsmanager:GetSecretValue"]
  resource_arn_list = ["${module.rds.rds_db_secret_arn}"]
}

module "iam_ecs_task_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.service_rsrc_type_ecs}-task"
  iam_role_principal_identifiers = "ecs-tasks.amazonaws.com"
}

module "iam_ecs_task_role_exec_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_ecs_task_role.iam_role_name
  iam_policy_arn = module.iam_ecs_exec_policy.iam_policy_arn
}

module "iam_ecs_task_role_s3_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_ecs_task_role.iam_role_name
  iam_policy_arn = module.iam_ecs_s3_policy.iam_policy_arn
}

module "iam_ecs_task_role_secret_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_ecs_task_role.iam_role_name
  iam_policy_arn = module.iam_ecs_secret_policy.iam_policy_arn
}

module "iam_ecs_task_exec_policy" {
  source              = "../../modules/iamservierolepolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "iam_ecs_task_exec_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.service_rsrc_type_ecs}-exec"
  iam_role_principal_identifiers = "ecs-tasks.amazonaws.com"
}

module "iam_ecs_task_exec_role_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_ecs_task_exec_role.iam_role_name
  iam_policy_arn = module.iam_ecs_task_exec_policy.iam_policy_arn
}

module "iam_ecs_task_exec_role_secret_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_ecs_task_exec_role.iam_role_name
  iam_policy_arn = module.iam_ecs_secret_policy.iam_policy_arn
}

module "iam_ecs_infra_policy" {
  count               = var.deployment_strategy == "ecs_blue_green_deployment" ? 1 : 0
  source              = "../../modules/iamservierolepolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/AmazonECSInfrastructureRolePolicyForLoadBalancers"
}

module "iam_ecs_infra_role" {
  count                          = var.deployment_strategy == "ecs_blue_green_deployment" ? 1 : 0
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.service_rsrc_type_ecs}-infra"
  iam_role_principal_identifiers = "ecs.amazonaws.com"
}

module "iam_ecs_infra_role_policy_attach" {
  count          = var.deployment_strategy == "ecs_blue_green_deployment" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_ecs_infra_role[0].iam_role_name
  iam_policy_arn = module.iam_ecs_infra_policy[0].iam_policy_arn
}

module "ecs_cluster" {
  source             = "../../modules/ecscluster"
  system             = var.system
  project            = var.project
  environment        = var.environment
  resourcetype       = var.service_rsrc_type_ecs
  outbound_route_ids = module.internetgateway.internet_route_id
}

module "ecs_service" {
  source                       = "../../modules/ecsservice"
  system                       = var.system
  project                      = var.project
  environment                  = var.environment
  resourcetype                 = var.service_rsrc_type_ecs
  ecs_cluster_arn              = module.ecs_cluster.ecs_cluster_arn
  ecs_service_desired_count    = var.ecs_service_desired_count
  ecs_container_name           = var.app_container_name
  ecs_container_port           = var.app_container_port
  associate_public_ip_address  = var.has_public_ip_to_container
  deployment_strategy          = var.deployment_strategy
  subnet_1a_id                 = module.private_1a_subnet.subnet_id
  subnet_1c_id                 = module.private_1c_subnet.subnet_id
  security_group_id            = module.ecs_sg.security_group_id
  target_group_arn             = module.alb_blue_tg.alb_tg_arn
  ecs_task_definition_arn      = module.ecs_task.ecs_task_arn
  alternate_target_group_arn   = var.deployment_strategy == "ecs_blue_green_deployment" ? module.alb_green_tg[0].alb_tg_arn : null
  production_listener_rule_arn = var.deployment_strategy == "ecs_blue_green_deployment" ? module.alb_blue_tg.alb_lsnr_rule_arn : null
  test_listener_rule_arn       = var.deployment_strategy == "ecs_blue_green_deployment" ? module.alb_green_tg[0].alb_lsnr_rule_arn : null
  ecs_infra_role_arn           = var.deployment_strategy == "ecs_blue_green_deployment" ? module.iam_ecs_infra_role[0].iam_role_arn : null
}

module "ecs_task" {
  source                     = "../../modules/ecstask"
  aws_region                 = var.aws_region
  system                     = var.system
  project                    = var.project
  environment                = var.environment
  resourcetype               = var.service_rsrc_type_ecs
  cpu_for_ecs_task           = var.ecs_task_cpu
  memory_for_ecs_task        = var.ecs_task_memory
  ecs_task_role_arn          = module.iam_ecs_task_role.iam_role_arn
  ecs_task_exec_role_arn     = module.iam_ecs_task_exec_role.iam_role_arn
  ecs_task_cpu               = var.ecs_task_cpu
  ecs_task_memory            = var.ecs_task_memory
  container_definitions_file = "src/container_definitions.json"
  app_image_tag              = var.app_image_tag
  app_container_name         = var.app_container_name
  http_port                  = var.app_container_port
  db_secret_arn              = module.rds.rds_db_secret_arn
  error_log_stream_prefix    = var.app_container_name
  ecr_repository_url         = module.ecr.ecr_repository_url
  error_log_group_name       = module.frontend_error_log_group.log_group_name
  ecr_app_push_id            = module.ecr_app_push.docker_push_id
  outbound_route_ids         = module.internetgateway.internet_route_id
}

module "frontend_error_log_group" {
  source         = "../../modules/cloudwatchloggroup"
  log_group_name = "/aws/ecs/${var.app_container_name}/${var.environment}"
}

module "iam_rds_policy" {
  source              = "../../modules/iamservierolepolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

module "iam_rds_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_rds
  iam_role_principal_identifiers = "monitoring.rds.amazonaws.com"
}

module "iam_rds_role_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_rds_role.iam_role_name
  iam_policy_arn = module.iam_rds_policy.iam_policy_arn
}

module "rds" {
  source                   = "../../modules/rds"
  system                   = var.system
  project                  = var.project
  environment              = var.environment
  deletion_protection      = var.deletion_protection
  multi_az                 = var.multi_az
  rds_engine               = var.rds_engine
  rds_engine_major_version = var.rds_engine_major_version
  rds_engine_minor_version = var.rds_engine_minor_version
  rds_port                 = var.rds_port
  security_group_id        = module.rds_sg.security_group_id
  db_instance_class        = var.db_instance_class
  db_name                  = "${var.system}${var.project}${var.environment}db"
  db_root_name             = var.db_root_name
  db_storage_type          = var.db_storage_type
  db_allocated_storage     = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_storage_encrypted     = var.db_storage_encrypted
  # db_enabled_cloudwatch_logs_exports = ["error", "slowquery", "audit", "general"]
  db_backup_retention_period               = var.db_backup_retention_period
  db_backup_window                         = var.db_backup_window
  db_maintenance_window                    = var.db_maintenance_window
  db_performance_insights_enabled          = var.db_performance_insights_enabled
  db_performance_insights_retention_period = var.db_performance_insights_retention_period
  db_monitoring_role_arn                   = module.iam_rds_role.iam_role_arn
  db_monitoring_interval                   = var.db_monitoring_interval
  db_auto_minor_version_upgrade            = var.db_auto_minor_version_upgrade
  isolated_1a_subnet_id                    = module.isolated_1a_subnet.subnet_id
  isolated_1c_subnet_id                    = module.isolated_1c_subnet.subnet_id
  backup_tag_key                           = var.backup_tag_key
  backup_tag_value                         = "true"
  db_secret_rotate                         = var.db_secret_rotate
}

module "iam_backup_backup_policy" {
  source              = "../../modules/iamservierolepolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

module "iam_backup_restores_policy" {
  source              = "../../modules/iamservierolepolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

module "iam_backup_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_backup
  iam_role_principal_identifiers = "backup.amazonaws.com"
}

module "iam_backup_backup_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_backup_role.iam_role_name
  iam_policy_arn = module.iam_backup_backup_policy.iam_policy_arn
}

module "iam_backup_restores_policy_attach" {
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_backup_role.iam_role_name
  iam_policy_arn = module.iam_backup_restores_policy.iam_policy_arn
}

module "backup_common" {
  source        = "../../modules/backupcommon"
  system        = var.system
  project       = var.project
  environment   = var.environment
  resourcetype  = var.service_rsrc_type_backup
  force_destroy = var.force_destroy
}

module "backup_rds" {
  source              = "../../modules/backuprds"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = var.service_rsrc_type_backup
  backup_vault_name   = module.backup_common.backup_vault_name
  backup_role_arn     = module.iam_backup_role.iam_role_arn
  schedule_expression = var.backup_schedule_expression
  delete_after_days   = var.backup_delete_after_days
  backup_tag_key      = var.backup_tag_key
}

module "route53_record" {
  count               = var.naked_domain == null ? 0 : 1
  source              = "../../modules/route53record"
  route53_zone_name   = var.naked_domain
  route53_record_name = "${var.sub_domain}.${var.naked_domain}"
  alb_dns_name        = module.alb.alb_dns_name
  alb_zone_id         = module.alb.alb_zone_id
}

module "acm" {
  source            = "../../modules/acm"
  count             = var.naked_domain == null ? 0 : 1
  system            = var.system
  project           = var.project
  environment       = var.environment
  route53_zone_name = var.naked_domain
  acm_domain_name   = var.naked_domain
  acm_sans          = "*.${var.naked_domain}"
}

module "acm_self_signed" {
  source      = "../../modules/acmselfsigned"
  count       = var.naked_domain == null ? 1 : 0
  environment = var.environment
  common_name = module.alb.alb_dns_name
}

module "codeconnection" {
  count                = var.deployment_strategy != null ? 1 : 0
  source               = "../../modules/codeconnection"
  code_connection_name = var.code_connection_name
}

module "iam_codebuild_logs_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_build}-logs"
  action_list       = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
  resource_arn_list = ["*"]
}

module "iam_codebuild_bucket_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_build}-bucket"
  action_list       = ["s3:GetObject", "s3:GetObjectVersion", "s3:PutObject", "s3:GetBucketAcl", "s3:GetBucketLocation"]
  resource_arn_list = ["*"]
}


module "iam_codebuild_ecr_policy" {
  count        = var.deployment_strategy != null ? 1 : 0
  source       = "../../modules/iampolicy"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = "${var.service_rsrc_type_build}-ecr"
  action_list = ["ecr:BatchCheckLayerAvailability", "ecr:BatchGetImage", "ecr:CompleteLayerUpload", "ecr:GetDownloadUrlForLayer",
  "ecr:GetAuthorizationToken", "ecr:InitiateLayerUpload", "ecr:PutImage", "ecr:UploadLayerPart"]
  resource_arn_list = ["*"]
}

module "iam_codebuild_vpc_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_build}-vpc"
  action_list       = ["ec2:CreateNetworkInterface", "ec2:DescribeDhcpOptions", "ec2:DescribeNetworkInterfaces", "ec2:DeleteNetworkInterface", "ec2:DescribeSubnets", "ec2:DescribeSecurityGroups", "ec2:DescribeVpcs"]
  resource_arn_list = ["*"]
}

module "iam_codebuild_subnet_policy" {
  count              = var.deployment_strategy != null ? 1 : 0
  source             = "../../modules/iampolicy"
  system             = var.system
  project            = var.project
  environment        = var.environment
  resourcetype       = "${var.service_rsrc_type_build}-subnet"
  action_list        = ["ec2:CreateNetworkInterfacePermission"]
  resource_arn_list  = ["arn:aws:ec2:${var.aws_region}:${module.account.id}:network-interface/*"]
  condition_test     = "ArnEquals"
  condition_variable = "ec2:Subnet"
  condition_values   = ["arn:aws:ec2:${var.aws_region}:${module.account.id}:subnet/${module.private_1a_subnet.subnet_id}", "arn:aws:ec2:${var.aws_region}:${module.account.id}:subnet/${module.private_1c_subnet.subnet_id}"]
}

module "iam_codebuild_role" {
  count                          = var.deployment_strategy != null ? 1 : 0
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_build
  iam_role_principal_identifiers = "codebuild.amazonaws.com"
}

module "iam_codebuild_role_logs_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codebuild_role[0].iam_role_name
  iam_policy_arn = module.iam_codebuild_logs_policy[0].iam_policy_arn
}

module "iam_codebuild_role_bucket_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codebuild_role[0].iam_role_name
  iam_policy_arn = module.iam_codebuild_bucket_policy[0].iam_policy_arn
}

module "iam_codebuild_role_ecr_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codebuild_role[0].iam_role_name
  iam_policy_arn = module.iam_codebuild_ecr_policy[0].iam_policy_arn
}

module "iam_codebuild_role_vpc_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codebuild_role[0].iam_role_name
  iam_policy_arn = module.iam_codebuild_vpc_policy[0].iam_policy_arn
}

module "iam_codebuild_role_subnet_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codebuild_role[0].iam_role_name
  iam_policy_arn = module.iam_codebuild_subnet_policy[0].iam_policy_arn
}

module "codebuild_app" {
  count                      = var.deployment_strategy != null ? 1 : 0
  source                     = "../../modules/codebuild"
  system                     = var.system
  project                    = var.project
  environment                = var.environment
  resourcetype               = "${var.service_rsrc_type_build}-app"
  deployment_strategy        = var.deployment_strategy
  codebuild_vpc_id           = module.vpc.vpc_id
  codebuild_subnet_ids       = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  codebuild_sg_ids           = [module.codebuild_sg.security_group_id]
  buildspec_codedeploy_file  = "src/buildspec_codedeploy.yml"
  buildspec_ecs_file         = "src/buildspec_ecs.yml"
  codebuild_compute_type     = var.codebuild_compute_type
  codebuild_image            = var.codebuild_image
  account_id                 = module.account.id
  docker_file_path           = var.github_docker_file_path
  taskdef_file_path          = var.github_taskdef_file_path
  appspec_file_path          = var.github_appspec_file_path
  codebuild_log_group_name   = module.codebuild_app_log_group[0].log_group_name
  app_container_name         = var.app_container_name
  app_http_port              = var.app_container_port
  db_secret_arn              = module.rds.rds_db_secret_arn
  error_log_stream_prefix    = "${var.app_container_name}_sidecar"
  error_log_group_name       = module.frontend_error_log_group.log_group_name
  codebuild_role_arn         = module.iam_codebuild_role[0].iam_role_arn
  ecr_repository_url         = module.ecr.ecr_repository_url
  ecs_task_definition_family = module.ecs_task.ecs_task_family
  ecs_task_role_arn          = module.iam_ecs_task_role.iam_role_arn
  ecs_exec_role_arn          = module.iam_ecs_task_exec_role.iam_role_arn
  ecs_task_cpu               = var.ecs_task_cpu
  ecs_task_memory            = var.ecs_task_memory
}

module "codebuild_app_log_group" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/cloudwatchloggroup"
  log_group_name = "/aws/codebuild/app/${var.environment}"
}

module "iam_codedeploy_policy" {
  count               = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source              = "../../modules/iamservierolepolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

module "iam_codedeploy_role" {
  count                          = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_deploy
  iam_role_principal_identifiers = "codedeploy.amazonaws.com"
}

module "iam_codedeploy_role_policy_attach" {
  count          = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codedeploy_role[0].iam_role_name
  iam_policy_arn = module.iam_codedeploy_policy[0].iam_policy_arn
}

module "codedeploy" {
  count                  = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source                 = "../../modules/codedeploy"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.service_rsrc_type_deploy
  codedeploy_role_arn    = module.iam_codedeploy_role[0].iam_role_arn
  ecs_cluster_name       = module.ecs_cluster.ecs_cluster_name
  ecs_service_name       = module.ecs_service.ecs_service_name
  blue_listener_arn      = module.alb_blue_https_listener.listener_arn
  green_listener_arn     = module.alb_green_https_listener[0].listener_arn
  blue_tg_name           = module.alb_blue_tg.alb_tg_name
  green_tg_name          = module.alb_green_tg[0].alb_tg_name
  deployment_config_name = var.deployment_config_name
}

module "s3_artifact_bucket" {
  count              = var.deployment_strategy != null ? 1 : 0
  source             = "../../modules/s3artifactbucket"
  system             = var.system
  project            = var.project
  environment        = var.environment
  account_id         = module.account.id
  versioning_enabled = var.versioning_enabled
  force_destroy      = var.force_destroy
}

module "iam_codepipeline_bucket_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-bucket"
  action_list       = ["s3:GetBucketVersioning", "s3:GetBucketAcl", "s3:GetBucketLocation"]
  resource_arn_list = [module.s3_artifact_bucket[0].bucket_arn]
}

module "iam_codepipeline_object_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-object"
  action_list       = ["s3:PutObject", "s3:PutObjectAcl", "s3:GetObject", "s3:GetObjectVersion", "s3:PutObjectTagging", "s3:GetObjectTagging", "s3:GetObjectVersionTagging"]
  resource_arn_list = ["${module.s3_artifact_bucket[0].bucket_arn}/*"]
}

module "iam_codepipeline_connection_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-connection"
  action_list       = ["codestar-connections:UseConnection"]
  resource_arn_list = [module.codeconnection[0].code_connection_arn]
}

module "iam_codepipeline_build_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-build"
  action_list       = ["codebuild:BatchGetBuilds", "codebuild:StartBuild", "codebuild:BatchGetBuildBatches", "codebuild:StartBuildBatch"]
  resource_arn_list = [module.codebuild_app[0].codebuild_project_arn]
}

module "iam_codepipeline_deploy_deployment_policy" {
  count             = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-deploy-deployment"
  action_list       = ["codedeploy:CreateDeployment", "codedeploy:GetDeployment"]
  resource_arn_list = [module.codedeploy[0].codedeploy_group_arn]
}

module "iam_codepipeline_application_policy" {
  count             = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-deploy-application"
  action_list       = ["codedeploy:GetApplication", "codedeploy:GetApplicationRevision", "codedeploy:RegisterApplicationRevision"]
  resource_arn_list = [module.codedeploy[0].codedeploy_app_arn, "${module.codedeploy[0].codedeploy_app_arn}/*"]
}

module "iam_codepipeline_deploy_config_policy" {
  count             = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-deploy-config"
  action_list       = ["codedeploy:GetDeploymentConfig"]
  resource_arn_list = ["*"]
}

module "iam_codepipeline_ecs_task_policy" {
  count             = var.deployment_strategy != null ? 1 : 0
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-ecs-task"
  action_list       = ["ecs:DescribeTaskDefinition", "ecs:RegisterTaskDefinition"]
  resource_arn_list = ["*"]
}

module "iam_codepipeline_ecs_service_policy" {
  count             = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 0 : 1
  source            = "../../modules/iampolicy"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "${var.service_rsrc_type_pipeline}-ecs-service"
  action_list       = ["ecs:DescribeServices", "ecs:UpdateService"]
  resource_arn_list = ["${module.ecs_cluster.ecs_cluster_arn}/*"]
}

module "iam_codepipeline_ecs_tag_policy" {
  count              = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 0 : 1
  source             = "../../modules/iampolicy"
  system             = var.system
  project            = var.project
  environment        = var.environment
  resourcetype       = "${var.service_rsrc_type_pipeline}-ecs-tag"
  action_list        = ["ecs:TagResource"]
  resource_arn_list  = ["arn:aws:ecs:*:${module.account.id}:task-definition/${module.ecs_task.ecs_task_family}:*"]
  condition_test     = "StringEquals"
  condition_variable = "ecs:CreateAction"
  condition_values   = ["RegisterTaskDefinition"]
}

module "iam_codepipeline_passrole_policy" {
  count              = var.deployment_strategy != null ? 1 : 0
  source             = "../../modules/iampolicy"
  system             = var.system
  project            = var.project
  environment        = var.environment
  resourcetype       = "${var.service_rsrc_type_pipeline}-passrole"
  action_list        = ["iam:PassRole"]
  resource_arn_list  = ["arn:aws:iam::${module.account.id}:role/*"]
  condition_test     = "StringEquals"
  condition_variable = "iam:PassedToService"
  condition_values   = ["ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
}

module "iam_codepipeline_role" {
  count                          = var.deployment_strategy != null ? 1 : 0
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_pipeline
  iam_role_principal_identifiers = "codepipeline.amazonaws.com"
}

module "iam_codepipeline_connection_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_connection_policy[0].iam_policy_arn
}

module "iam_codepipeline_role_bucket_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_bucket_policy[0].iam_policy_arn
}

module "iam_codepipeline_object_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_object_policy[0].iam_policy_arn
}

module "iam_codepipeline_build_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_build_policy[0].iam_policy_arn
}

module "iam_codepipeline_deploy_deployment_policy_attach" {
  count          = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_deploy_deployment_policy[0].iam_policy_arn
}

module "iam_codepipeline_application_policy_attach" {
  count          = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_application_policy[0].iam_policy_arn
}

module "iam_codepipeline_deploy_config_policy_attach" {
  count          = var.deployment_strategy == "codedeploy_blue_green_deployment" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_deploy_config_policy[0].iam_policy_arn
}

module "iam_codepipeline_ecs_task_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_ecs_task_policy[0].iam_policy_arn
}

module "iam_codepipeline_ecs_service_policy_attach" {
  count          = var.deployment_strategy == "ecs_rolling_update" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_ecs_service_policy[0].iam_policy_arn
}

module "iam_codepipeline_ecs_tag_policy_attach" {
  count          = var.deployment_strategy == "ecs_rolling_update" ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_ecs_tag_policy[0].iam_policy_arn
}

module "iam_codepipeline_passrole_policy_attach" {
  count          = var.deployment_strategy != null ? 1 : 0
  source         = "../../modules/iamrolepolicyattach"
  iam_role_name  = module.iam_codepipeline_role[0].iam_role_name
  iam_policy_arn = module.iam_codepipeline_passrole_policy[0].iam_policy_arn
}


module "codepipeline" {
  count                    = var.deployment_strategy != null ? 1 : 0
  source                   = "../../modules/codepipeline"
  system                   = var.system
  project                  = var.project
  environment              = var.environment
  resourcetype             = var.service_rsrc_type_pipeline
  deployment_strategy      = var.deployment_strategy
  enable_approval_stage    = var.enable_approval_stage
  code_connection_arn      = module.codeconnection[0].code_connection_arn
  github_repository_owner  = var.github_repository_owner
  github_repository_name   = var.github_repository_name
  github_branch_name       = var.github_branch_name
  taskdef_file_path        = var.github_taskdef_file_path
  appspec_file_path        = var.github_appspec_file_path
  codepipeline_role_arn    = module.iam_codepipeline_role[0].iam_role_arn
  artifact_bucket          = module.s3_artifact_bucket[0].bucket_name
  codebuild_app_project_id = module.codebuild_app[0].codebuild_project_id
  ecs_cluster_id           = var.deployment_strategy == "ecs_rolling_update" ? module.ecs_cluster.ecs_cluster_id : null
  ecs_service_name         = var.deployment_strategy == "ecs_rolling_update" ? module.ecs_service.ecs_service_name : null
  codedeploy_app_name      = var.deployment_strategy == "codedeploy_blue_green_deployment" ? module.codedeploy[0].codedeploy_app_name : null
  codedeploy_group_name    = var.deployment_strategy == "codedeploy_blue_green_deployment" ? module.codedeploy[0].codedeploy_group_name : null
}
