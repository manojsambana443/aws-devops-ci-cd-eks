locals { name = var.cluster_name }

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "~> 5.0"
  name               = "${local.name}-vpc"
  cidr               = "10.0.0.0/16"
  azs                = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"
  cluster_name    = local.name
  cluster_version = "1.30"
  cluster_endpoint_public_access        = true
  cluster_endpoint_public_access_cidrs  = ["49.37.132.166/32"]
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      min_size       = 2
      max_size       = 6
    }
  }
}

resource "aws_ecr_repository" "app" {
  name                 = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
}
