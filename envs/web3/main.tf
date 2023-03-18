# ====================
#
# Terraform
#
# ====================

terraform {
  required_version = ">=1.0.0"

  # backend "s3" {
  #   bucket = "tsukuboshi-bucket-tf-backend"
  #   key    = "terraform.tfstate"
  #   region = "ap-northeast-1"

  #   dynamodb_table = "tsukuboshi-ddb-tf-backend"
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# ====================
#
# Provider
#
# ====================

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Prj = var.project
      Env = var.environment
    }
  }
}

provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
  default_tags {
    tags = {
      Prj = var.project
      Env = var.environment
    }
  }
}

# ====================
#
# Modules
#
# ====================

module "vpc" {
  source         = "../../modules/vpc"
  system         = var.system
  project        = var.project
  environment    = var.environment
  vpc_cidr_block = var.vpc_cidr_block
  has_flow_log   = false
  # flow_log_bucket_arn                 = module.s3_vpc_log_bucket.bucket_arn
  # flow_log_file_format                = var.flow_log_file_format_text
  # flow_log_hive_compatible_partitions = false
  # flow_log_per_hour_partition         = false
}

# module "s3_vpc_log_bucket" {
#   source                 = "../../modules/s3logbucket"
#   system                 = var.system
#   project                = var.project
#   environment            = var.environment
#   resourcetype           = var.s3_rsrc_type_vpc
#   internal               = var.internal
#   object_ownership       = var.disabled_s3_acl
#   object_expiration_days = var.object_expiration_days
# }

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

# module "public_1a_natgateway" {
#   source         = "../../modules/natgateway"
#   system         = var.system
#   project        = var.project
#   environment    = var.environment
#   resourcetype   = "${var.network_rsrc_type_public}-${var.az_short_name_1a}"
#   subnet_id      = module.public_1a_subnet.subnet_id
#   igw_id         = module.internetgateway.igw_id
#   route_table_id = module.private_1a_routetable.route_table_id
# }

# module "public_1c_natgateway" {
#   source         = "../../modules/natgateway"
#   system         = var.system
#   project        = var.project
#   environment    = var.environment
#   resourcetype   = "${var.network_rsrc_type_public}-${var.az_short_name_1c}"
#   subnet_id      = module.public_1c_subnet.subnet_id
#   igw_id         = module.internetgateway.igw_id
#   route_table_id = module.private_1c_routetable.route_table_id
# }

module "s3_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "s3"
  vpc_endpoint_type   = "Gateway"
  service_name        = "com.amazonaws.ap-northeast-1.s3"
  vpc_id              = module.vpc.vpc_id
  is_gateway_endpoint = true
  route_table_1a_id   = module.private_1a_routetable.route_table_id
  route_table_1c_id   = module.private_1c_routetable.route_table_id
}

module "ecr_dkr_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ecr-dkr"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
}

module "ecr_api_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ecr-api"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
}

module "logs_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "logs"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
}

module "ssm_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ssm"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ssm"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
}

module "ssmmessages_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ssmmessages"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ssmmessages"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
}

module "ec2messages_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "ec2messages"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.ec2messages"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
}

module "firehose_endpoint" {
  source              = "../../modules/vpcendpoint"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = "firehose"
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.ap-northeast-1.kinesis-firehose"
  private_dns_enabled = true
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = [module.private_1a_subnet.subnet_id, module.private_1c_subnet.subnet_id]
  security_group_ids  = [module.endpoint_sg.security_group_id]
  is_gateway_endpoint = false
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

module "cache_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_cache
  vpc_id       = module.vpc.vpc_id
}

module "endpoint_sg" {
  source       = "../../modules/securitygroup"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = "endpoint"
  vpc_id       = module.vpc.vpc_id
}

module "alb_sg_ingress_rule_http" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = 80
  sg_rule_to_port     = 80
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_sg_ingress_rule_https" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.alb_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = 443
  sg_rule_to_port     = 443
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
  sg_rule_from_port                = 80
  sg_rule_to_port                  = 80
  sg_rule_source_security_group_id = module.alb_sg.security_group_id
}

# module "ecs_sg_ingress_rule_ssh" {
#   source                           = "../../modules/securitygrouprule"
#   system                           = var.system
#   project                          = var.project
#   environment                      = var.environment
#   security_group_id                = module.ecs_sg.security_group_id
#   sg_rule_type                     = "ingress"
#   sg_rule_protocol                 = "tcp"
#   sg_rule_from_port                = 22
#   sg_rule_to_port                  = 22
#   sg_rule_cidr_blocks              = ["xxx.xxx.xxx.xxx"]
# }

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


module "rds_sg_ingress_rule_mysql" {
  source                           = "../../modules/securitygrouprule"
  system                           = var.system
  project                          = var.project
  environment                      = var.environment
  security_group_id                = module.rds_sg.security_group_id
  sg_rule_type                     = "ingress"
  sg_rule_protocol                 = "tcp"
  sg_rule_from_port                = 3306
  sg_rule_to_port                  = 3306
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

module "cache_sg_ingress_rule_redis" {
  source                           = "../../modules/securitygrouprule"
  system                           = var.system
  project                          = var.project
  environment                      = var.environment
  security_group_id                = module.cache_sg.security_group_id
  sg_rule_type                     = "ingress"
  sg_rule_protocol                 = "tcp"
  sg_rule_from_port                = 6379
  sg_rule_to_port                  = 6379
  sg_rule_source_security_group_id = module.ecs_sg.security_group_id
}

module "cache_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.cache_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "endpoint_sg_ingress_rule_https" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.endpoint_sg.security_group_id
  sg_rule_type        = "ingress"
  sg_rule_protocol    = "tcp"
  sg_rule_from_port   = 443
  sg_rule_to_port     = 443
  sg_rule_cidr_blocks = [var.vpc_cidr_block]
}

module "endpoint_sg_egress_rule_all" {
  source              = "../../modules/securitygrouprule"
  system              = var.system
  project             = var.project
  environment         = var.environment
  security_group_id   = module.endpoint_sg.security_group_id
  sg_rule_type        = "egress"
  sg_rule_protocol    = -1
  sg_rule_from_port   = 0
  sg_rule_to_port     = 0
  sg_rule_cidr_blocks = ["0.0.0.0/0"]
}

module "route53_record" {
  source              = "../../modules/route53record"
  route53_zone_name   = var.naked_domain
  route53_record_name = "${var.sub_domain}.${var.naked_domain}"
  alb_dns_name        = module.alb.alb_dns_name
  alb_zone_id         = module.alb.alb_zone_id
}

module "acm" {
  source            = "../../modules/acm"
  system            = var.system
  project           = var.project
  environment       = var.environment
  route53_zone_name = var.naked_domain
  acm_domain_name   = var.naked_domain
  acm_sans          = "*.${var.naked_domain}"
}


module "alb" {
  source                 = "../../modules/alb"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  internal               = var.internal
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
  http_port         = 80
  redirect_port     = 443
  load_balancer_arn = module.alb.alb_arn
}

module "alb_blue_https_listener" {
  source                = "../../modules/albhttpslistener"
  system                = var.system
  project               = var.project
  environment           = var.environment
  resourcetype          = "blue"
  https_port            = 443
  load_balancer_arn     = module.alb.alb_arn
  acm_alb_cert_arn      = module.acm.acm_alb_cert_arn
  acm_alb_cert_valid_id = module.acm.acm_alb_cert_valid_id
}

module "alb_green_http_listener" {
  source            = "../../modules/albhttplistener"
  system            = var.system
  project           = var.project
  environment       = var.environment
  resourcetype      = "green"
  http_port         = 8080
  redirect_port     = 8443
  load_balancer_arn = module.alb.alb_arn
}

module "alb_green_https_listener" {
  source                = "../../modules/albhttpslistener"
  system                = var.system
  project               = var.project
  environment           = var.environment
  resourcetype          = "green"
  https_port            = 8443
  load_balancer_arn     = module.alb.alb_arn
  acm_alb_cert_arn      = module.acm.acm_alb_cert_arn
  acm_alb_cert_valid_id = module.acm.acm_alb_cert_valid_id
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
  alb_lsnr_rule_host_header = "${var.sub_domain}.${var.naked_domain}"
}

module "alb_green_tg" {
  source                    = "../../modules/albtargetgroup"
  system                    = var.system
  project                   = var.project
  environment               = var.environment
  resourcetype              = "green"
  vpc_id                    = module.vpc.vpc_id
  alb_target_type           = var.alb_target_type_ecs
  alb_lsnr_https_arn        = module.alb_green_https_listener.listener_arn
  alb_lsnr_rule_priority    = 100
  has_host_header           = true
  alb_lsnr_rule_host_header = "${var.sub_domain}.${var.naked_domain}"
}

module "s3_alb_log_bucket" {
  source                 = "../../modules/s3logbucket"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.s3_rsrc_type_alb
  internal               = var.internal
  object_ownership       = var.disabled_s3_acl
  object_expiration_days = var.object_expiration_days
}

module "s3_alb_log_bucket_policy" {
  source                 = "../../modules/s3logbucketpolicy"
  access_log_bucket_name = module.s3_alb_log_bucket.bucket_name
  access_log_bucket_id   = module.s3_alb_log_bucket.bucket_id
  access_log_prefix      = var.access_log_prefix
}

# module "waf" {
#   source                         = "../../modules/waf"
#   system                         = var.system
#   project                        = var.project
#   environment                    = var.environment
#   resourcetype                   = var.waf_rsrc_type_alb
# waf_block_mode                 = true
#   waf_cloudwatch_metrics_enabled = true
#   waf_sampled_requests_enabled   = true
#   alb_arn                        = module.alb.alb_arn
#   has_web_acl_log                = true
#   waf_log_bucket_arn             = module.s3_waf_log_bucket.bucket_arn
# }

# module "s3_waf_log_bucket" {
#   source                 = "../../modules/s3logbucket"
#   system                 = var.system
#   project                = var.project
#   environment            = var.environment
#   resourcetype           = var.s3_rsrc_type_waf
#   internal               = var.internal
#   object_ownership       = var.disabled_s3_acl
#   object_expiration_days = var.object_expiration_days
# }

module "ecr" {
  source                       = "../../modules/ecr"
  system                       = var.system
  project                      = var.project
  environment                  = var.environment
  resourcetype                 = var.service_rsrc_type_ecs
  internal                     = var.internal
  image_count_lifecycle_policy = 30
}

module "ecr_login" {
  source             = "../../modules/ecrlogin"
  aws_region         = var.aws_region
  ecr_repository_arn = module.ecr.ecr_repository_arn
  ecr_repository_url = module.ecr.ecr_repository_url
}

module "docker_start" {
  source = "../../modules/dockerstart"
}

module "ecr_frontend_push" {
  source             = "../../modules/dockerpush"
  aws_region         = var.aws_region
  system             = var.system
  project            = var.project
  environment        = var.environment
  image_name         = var.frontend_image_name
  container_name     = var.frontend_container_name
  dockerfile_path    = "src/${var.frontend_image_name}/Dockerfile"
  ecr_login_id       = module.ecr_login.ecr_login_id
  docker_start_id    = module.docker_start.docker_start_id
  ecr_repository_url = module.ecr.ecr_repository_url
}

module "ecr_firelens_push" {
  source             = "../../modules/dockerpush"
  aws_region         = var.aws_region
  system             = var.system
  project            = var.project
  environment        = var.environment
  image_name         = var.firelens_image_name
  container_name     = var.firelens_container_name
  dockerfile_path    = "src/${var.firelens_image_name}/Dockerfile"
  ecr_login_id       = module.ecr_login.ecr_login_id
  docker_start_id    = module.docker_start.docker_start_id
  ecr_repository_url = module.ecr.ecr_repository_url
}

module "iam_ecs_task_policy" {
  source       = "../../modules/iamecspolicy"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = "${var.service_rsrc_type_ecs}-task"
  firehose_arn = module.firehose.firehose_arn
}

module "iam_ecs_task_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.service_rsrc_type_ecs}-task"
  iam_role_principal_identifiers = "ecs-tasks.amazonaws.com"
  iam_policy_arn                 = module.iam_ecs_task_policy.ecs_iam_policy_arn
}

module "iam_ecs_exec_policy" {
  source              = "../../modules/iammanagedpolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

module "iam_ecs_exec_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = "${var.service_rsrc_type_ecs}-exec"
  iam_role_principal_identifiers = "ecs-tasks.amazonaws.com"
  iam_policy_arn                 = module.iam_ecs_exec_policy.iam_policy_arn
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
  source                      = "../../modules/ecsservice"
  system                      = var.system
  project                     = var.project
  environment                 = var.environment
  resourcetype                = var.service_rsrc_type_ecs
  ecs_cluster_arn             = module.ecs_cluster.ecs_cluster_arn
  ecs_service_desired_count   = var.ecs_service_desired_count
  ecs_container_name          = var.frontend_container_name
  ecs_container_port          = 80
  associate_public_ip_address = var.has_public_ip_to_computer
  has_blue_green_deployment   = var.has_blue_green_deployment
  subnet_1a_id                = module.public_1a_subnet.subnet_id
  subnet_1c_id                = module.public_1c_subnet.subnet_id
  security_group_id           = module.ecs_sg.security_group_id
  target_group_arn            = module.alb_blue_tg.alb_tg_arn
  ecs_task_definition_arn     = module.ecs_task.ecs_task_arn
}

module "ecs_task" {
  source                     = "../../modules/ecstask"
  aws_region                 = var.aws_region
  system                     = var.system
  project                    = var.project
  environment                = var.environment
  resourcetype               = var.service_rsrc_type_ecs
  cpu_for_ecs_task           = "256"
  memory_for_ecs_task        = "512"
  ecs_task_role_arn          = module.iam_ecs_task_role.iam_role_arn
  ecs_exec_role_arn          = module.iam_ecs_exec_role.iam_role_arn
  container_definitions_file = "src/container_definitions.json"
  frontend_image_name        = var.frontend_image_name
  frontend_container_name    = var.frontend_container_name
  firelens_image_name        = var.firelens_image_name
  firelens_container_name    = var.firelens_container_name
  error_log_stream_prefix    = "${var.frontend_container_name}_sidecar"
  ecr_repository_url         = module.ecr.ecr_repository_url
  error_log_group_name       = module.firelens_error_log_group.log_group_name
  ecr_firelens_push_id       = module.ecr_firelens_push.docker_push_id
  ecr_frontend_push_id       = module.ecr_frontend_push.docker_push_id
  outbound_route_ids         = module.internetgateway.internet_route_id
}

module "firelens_error_log_group" {
  source         = "../../modules/cloudwatchloggroup"
  log_group_name = "/aws/ecs/firelens/log_router"
}

module "iam_firehose_policy" {
  source              = "../../modules/iamfirehosepolicy"
  system              = var.system
  project             = var.project
  environment         = var.environment
  resourcetype        = var.service_rsrc_type_firehose
  log_bucket_arn      = module.firehose_log_bucket.bucket_arn
  error_log_group_arn = module.firehose_error_log_group.log_group_arn
}

module "iam_firehose_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_firehose
  iam_role_principal_identifiers = "firehose.amazonaws.com"
  iam_policy_arn                 = module.iam_firehose_policy.firehose_iam_policy_arn
}

module "firehose" {
  source                         = "../../modules/kinesisfirehose"
  firehose_delivery_stream_name  = "${var.service_rsrc_type_firehose}-delivery-stream"
  firehose_iam_role_arn          = module.iam_firehose_role.iam_role_arn
  log_bucket_arn                 = module.firehose_log_bucket.bucket_arn
  firehose_error_log_group_name  = module.firehose_error_log_group.log_group_name
  firehose_error_log_stream_name = module.firehose_error_log_stream.log_stream_name
}

module "firehose_error_log_group" {
  source         = "../../modules/cloudwatchloggroup"
  log_group_name = "/aws/firehose/delivery/error"
}

module "firehose_error_log_stream" {
  source          = "../../modules/cloudwatchlogstream"
  log_group_name  = module.firehose_error_log_group.log_group_name
  log_stream_name = "firehose"
}

module "firehose_log_bucket" {
  source                 = "../../modules/s3logbucket"
  system                 = var.system
  project                = var.project
  environment            = var.environment
  resourcetype           = var.service_rsrc_type_firehose
  internal               = var.internal
  object_ownership       = var.disabled_s3_acl
  object_expiration_days = var.object_expiration_days
}

module "codecommit" {
  source       = "../../modules/codecommit"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_commit
}

module "iam_codebuild_policy" {
  source       = "../../modules/iamcodebuildpolicy"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_build
}

module "iam_codebuild_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_build
  iam_role_principal_identifiers = "codebuild.amazonaws.com"
  iam_policy_arn                 = module.iam_codebuild_policy.codebuild_iam_policy_arn
}

module "codebuild_frontend" {
  source                       = "../../modules/codebuild"
  system                       = var.system
  project                      = var.project
  environment                  = var.environment
  resourcetype                 = "${var.service_rsrc_type_build}-frontend"
  has_blue_green_deployment    = var.has_blue_green_deployment
  buildspec_bgdeploy_file      = "src/httpd/buildspec_bgdeploy.yml"
  buildspec_rollingupdate_file = "src/buildspec_rollingupdate.yml"
  container_build_path         = "./httpd"
  codebuild_log_group_name     = module.codebuild_frontend_log_group.log_group_name
  frontend_container_name      = var.frontend_container_name
  firelens_container_name      = var.firelens_container_name
  error_log_stream_prefix      = "${var.frontend_container_name}_sidecar"
  error_log_group_name         = module.firelens_error_log_group.log_group_name
  codebuild_role_arn           = module.iam_codebuild_role.iam_role_arn
  ecr_repository_url           = module.ecr.ecr_repository_url
  ecs_task_definition_family   = module.ecs_task.ecs_task_family
  ecs_task_role_arn            = module.iam_ecs_task_role.iam_role_arn
  ecs_exec_role_arn            = module.iam_ecs_exec_role.iam_role_arn
}

module "codebuild_frontend_log_group" {
  source         = "../../modules/cloudwatchloggroup"
  log_group_name = "/aws/codebuild/frontend"
}

module "codebuild_firelens" {
  source                       = "../../modules/codebuild"
  system                       = var.system
  project                      = var.project
  environment                  = var.environment
  resourcetype                 = "${var.service_rsrc_type_build}-firelens"
  has_blue_green_deployment    = var.has_blue_green_deployment
  buildspec_bgdeploy_file      = "src/fluentbit/buildspec_bgdeploy.yml"
  buildspec_rollingupdate_file = "src/buildspec_rollingupdate.yml"
  container_build_path         = "./fluentbit"
  codebuild_log_group_name     = module.codebuild_firelens_log_group.log_group_name
  frontend_container_name      = var.frontend_container_name
  firelens_container_name      = var.firelens_container_name
  error_log_stream_prefix      = "${var.firelens_container_name}_sidecar"
  error_log_group_name         = module.firelens_error_log_group.log_group_name
  codebuild_role_arn           = module.iam_codebuild_role.iam_role_arn
  ecr_repository_url           = module.ecr.ecr_repository_url
  ecs_task_definition_family   = module.ecs_task.ecs_task_family
  ecs_task_role_arn            = module.iam_ecs_task_role.iam_role_arn
  ecs_exec_role_arn            = module.iam_ecs_exec_role.iam_role_arn
}

module "codebuild_firelens_log_group" {
  source         = "../../modules/cloudwatchloggroup"
  log_group_name = "/aws/codebuild/firelens"
}

module "iam_codedeploy_policy" {
  source              = "../../modules/iammanagedpolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

module "iam_codedeploy_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_deploy
  iam_role_principal_identifiers = "codedeploy.amazonaws.com"
  iam_policy_arn                 = module.iam_codedeploy_policy.iam_policy_arn
}

module "codedeploy" {
  source                    = "../../modules/codedeploy"
  system                    = var.system
  project                   = var.project
  environment               = var.environment
  resourcetype              = var.service_rsrc_type_deploy
  has_blue_green_deployment = var.has_blue_green_deployment
  codedeploy_role_arn       = module.iam_codedeploy_role.iam_role_arn
  ecs_cluster_name          = module.ecs_cluster.ecs_cluster_name
  ecs_service_name          = module.ecs_service.ecs_service_name
  blue_listener_arn         = module.alb_blue_https_listener.listener_arn
  green_listener_arn        = module.alb_green_https_listener.listener_arn
  blue_tg_name              = module.alb_blue_tg.alb_tg_name
  green_tg_name             = module.alb_green_tg.alb_tg_name
}

module "iam_codepipeline_policy" {
  source       = "../../modules/iamcodepipelinepolicy"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_pipeline
}

module "iam_codepipeline_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_pipeline
  iam_role_principal_identifiers = "codepipeline.amazonaws.com"
  iam_policy_arn                 = module.iam_codepipeline_policy.codepipeline_iam_policy_arn
}

module "s3_artifact_bucket" {
  source      = "../../modules/s3artifactbucket"
  system      = var.system
  project     = var.project
  environment = var.environment
  internal    = var.internal
}

module "codepipeline" {
  source                        = "../../modules/codepipeline"
  system                        = var.system
  project                       = var.project
  environment                   = var.environment
  resourcetype                  = var.service_rsrc_type_pipeline
  has_blue_green_deployment     = var.has_blue_green_deployment
  appspec_file                  = "src/appspec.yml"
  taskdef_file                  = "src/taskdef.json"
  codepipeline_role_arn         = module.iam_codepipeline_role.iam_role_arn
  artifact_bucket               = module.s3_artifact_bucket.bucket_name
  codecommit_repository_name    = module.codecommit.codecommit_repository_name
  codebuild_frontend_project_id = module.codebuild_frontend.codebuild_project_id
  codebuild_firelens_project_id = module.codebuild_firelens.codebuild_project_id
  ecs_cluster_id                = module.ecs_cluster.ecs_cluster_id
  ecs_service_name              = module.ecs_service.ecs_service_name
  codedeploy_app_name           = module.codedeploy.codedeploy_app_name
  codedeploy_group_name         = module.codedeploy.codedeploy_group_name
}

module "iam_eventbridge_policy" {
  source       = "../../modules/iameventbridgepolicy"
  system       = var.system
  project      = var.project
  environment  = var.environment
  resourcetype = var.service_rsrc_type_eventbridge
}

module "iam_eventbridge_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_eventbridge
  iam_role_principal_identifiers = "events.amazonaws.com"
  iam_policy_arn                 = module.iam_eventbridge_policy.eventbridge_iam_policy_arn
}

module "eventbridge" {
  source                    = "../../modules/eventbridge"
  system                    = var.system
  project                   = var.project
  environment               = var.environment
  resourcetype              = var.service_rsrc_type_eventbridge
  event_pattern_file        = "src/codepipeline_event_pattern.json"
  codecommit_repository_arn = module.codecommit.codecommit_repository_arn
  codepipeline_arn          = module.codepipeline.codepipeline_arn
  eventbridge_role_arn      = module.iam_eventbridge_role.iam_role_arn
}

module "iam_rds_policy" {
  source              = "../../modules/iammanagedpolicy"
  iam_role_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

module "iam_rds_role" {
  source                         = "../../modules/iamrole"
  system                         = var.system
  project                        = var.project
  environment                    = var.environment
  resourcetype                   = var.service_rsrc_type_rds
  iam_role_principal_identifiers = "monitoring.rds.amazonaws.com"
  iam_policy_arn                 = module.iam_rds_policy.iam_policy_arn
}

module "rdsaurora" {
  source                = "../../modules/rdsaurora"
  system                = var.system
  project               = var.project
  environment           = var.environment
  internal              = var.internal
  aurora_engine_version = var.aurora_engine_version
  security_group_id     = module.rds_sg.security_group_id
  db_instance_class     = var.db_instance_class
  # db_name                     = "${var.system}${var.project}${var.environment}db"
  db_root_name             = var.db_root_name
  db_root_pass             = var.db_root_pass
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
}

module "elasticache" {
  source                           = "../../modules/elasticache"
  system                           = var.system
  project                          = var.project
  environment                      = var.environment
  internal                         = var.internal
  cache_engine_version             = var.cache_engine_version
  security_group_id                = module.cache_sg.security_group_id
  cache_node_type                  = var.cache_node_type
  num_node_groups                  = var.num_node_groups
  replicas_per_node_group          = var.replicas_per_node_group
  cache_snapshot_retention_limit   = var.cache_snapshot_retention_limit
  cache_snapshot_window            = var.cache_snapshot_window
  cache_maintenance_window         = var.cache_maintenance_window
  cache_auto_minor_version_upgrade = var.cache_auto_minor_version_upgrade
  isolated_1a_subnet_id            = module.isolated_1a_subnet.subnet_id
  isolated_1c_subnet_id            = module.isolated_1c_subnet.subnet_id
}
