data "aws_availability_zones" "available" {
  state = "available"
}

resource "random_id" "default" {
  byte_length = 2
}

locals {
  # Add randomness to names to avoid collisions when multiple users are using this example
  vpc_name       = "${var.name_prefix}-${lower(random_id.default.hex)}"
  rds_identifier = "${var.name_prefix}-${lower(random_id.default.hex)}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name                  = local.vpc_name
  cidr                  = "10.200.0.0/16"
  secondary_cidr_blocks = ["100.64.0.0/16"] # Used for optimizing IP address usage by pods in an EKS cluster. See https://aws.amazon.com/blogs/containers/optimize-ip-addresses-usage-by-pods-in-your-amazon-eks-cluster/
  azs                   = [for az_name in slice(data.aws_availability_zones.available.names, 0, min(length(data.aws_availability_zones.available.names), 3)) : az_name]
  public_subnets        = [for k, v in module.vpc.azs : cidrsubnet(module.vpc.vpc_cidr_block, 5, k)]
  private_subnets       = [for k, v in module.vpc.azs : cidrsubnet(module.vpc.vpc_cidr_block, 5, k + 4)]
  database_subnets      = [for k, v in module.vpc.azs : cidrsubnet(module.vpc.vpc_cidr_block, 5, k + 8)]
  intra_subnets         = [for k, v in module.vpc.azs : cidrsubnet(element(module.vpc.vpc_secondary_cidr_blocks, 0), 5, k)]
  single_nat_gateway    = true
  enable_nat_gateway    = true
  private_subnet_tags = {
    # Needed if you are deploying EKS v1.14 or earlier to this VPC. Not needed for EKS v1.15+.
    "kubernetes.io/cluster/my-cluster" = "owned"
    # Needed if you are using EKS with the AWS Load Balancer Controller v2.1.1 or earlier. Not needed if you are using a version of the Load Balancer Controller later than v2.1.1.
    "kubernetes.io/cluster/my-cluster" = "shared"
    # Needed if you are deploying EKS and load balancers to private subnets.
    "kubernetes.io/role/internal-elb" = 1
  }
  public_subnet_tags = {
    # Needed if you are deploying EKS and load balancers to public subnets. Not needed if you are only using private subnets for the EKS cluster.
    "kubernetes.io/role/elb" = 1
  }
  intra_subnet_tags = {
    "foo" = "bar"
  }
  create_database_subnet_group      = true
  instance_tenancy                  = "default"
  vpc_flow_log_permissions_boundary = var.iam_role_permissions_boundary
  tags                              = var.tags
}

module "rds" {
  source = "../.."

  # provider alias is needed for every parent module supporting RDS backup replication is a separate region
  providers = {
    aws.region2 = aws.region2
  }

  vpc_id                               = module.vpc.vpc_id
  vpc_cidr                             = module.vpc.vpc_cidr_block
  database_subnet_group_name           = module.vpc.database_subnet_group_name
  engine                               = var.rds_engine
  engine_version                       = var.rds_engine_version
  family                               = var.rds_family
  major_engine_version                 = var.rds_major_engine_version
  instance_class                       = var.rds_instance_class
  identifier                           = local.rds_identifier
  db_name                              = var.rds_db_name
  username                             = var.rds_username
  manage_master_user_password          = var.rds_manage_master_user_password
  password                             = var.rds_password
  allocated_storage                    = var.rds_allocated_storage
  max_allocated_storage                = var.rds_max_allocated_storage
  deletion_protection                  = var.rds_deletion_protection
  monitoring_role_permissions_boundary = var.iam_role_permissions_boundary
  tags                                 = var.tags
}
