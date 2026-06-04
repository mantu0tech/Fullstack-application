module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "demo-eks"
  cluster_version = "1.35"

  # Use default VPC (simplest for demo)
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  # Enable public access (for testing)
  cluster_endpoint_public_access = true

  # Node group config
  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 2
      min_size     = 1

      instance_types = ["t2.medium"]
    }
  }
}