# Logging (Fluent Bit → CloudWatch Logs)

Apply the DaemonSet to ship container logs to CloudWatch. Ensure the node IAM role has permissions for `logs:CreateLogGroup`, `logs:CreateLogStream`, and `logs:PutLogEvents`.
