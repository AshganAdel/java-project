module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.29"

  addons = {
    coredns                = {
        most_recent = true
    }
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {
        most_recent = true
    }
    vpc-cni                = {
      before_compute = true
    }
  }

  endpoint_public_access = true
  endpoint_private_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.my_vpc.vpc_id
  subnet_ids               = [module.my_vpc.private_subnets[0], module.my_vpc.private_subnets[1]]
  control_plane_subnet_ids = [module.my_vpc.private_subnets[2], module.my_vpc.private_subnets[3]]

  eks_managed_node_groups = {
    example = {
      instance_types = ["m7i-flex.large"]

      min_size     = 2
      max_size     = 5
      desired_size = 2
    }
  }

  tags = {
    Project = "java"
  }
}