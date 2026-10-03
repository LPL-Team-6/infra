output "cluster_name" {
  value = aws_eks_cluster.caseauth.name
}

output "configure_kubectl" {
  value = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.caseauth.name}"
}
