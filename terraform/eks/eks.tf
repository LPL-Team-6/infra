resource "aws_eks_cluster" "caseauth" {
  name     = "caseauth-hackathon"
  role_arn = aws_iam_role.cluster.arn

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids              = aws_subnet.public[*].id
    endpoint_public_access  = true
    endpoint_private_access = false
  }

  depends_on = [aws_iam_role_policy_attachment.cluster]
}

resource "aws_eks_node_group" "caseauth" {
  cluster_name    = aws_eks_cluster.caseauth.name
  node_group_name = "caseauth-nodes"
  node_role_arn   = aws_iam_role.nodes.arn
  subnet_ids      = aws_subnet.public[*].id
  instance_types  = [var.instance_type]
  disk_size       = 20

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [aws_iam_role_policy_attachment.nodes]
}
