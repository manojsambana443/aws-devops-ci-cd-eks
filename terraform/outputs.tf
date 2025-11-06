output "cluster_name" { value = var.cluster_name }
output "ecr_repo_url" { value = aws_ecr_repository.app.repository_url }
output "kubeconfig_cmd" {
  value = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.aws_region}"
}
