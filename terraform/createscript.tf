data "aws_subnets" "default" {
    filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "null_resource" "create-script" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
echo '#!/usr/bin/env bash' > ../startecs.sh
echo 'set -euo pipefail' >> ../startecs.sh
echo '# Start an ECS task with execute command enabled' >> ../startecs.sh
echo '# Usage: AWS_PROFILE=your-profile ./startecs.sh' >> ../startecs.sh

echo 'export CLUSTER="${aws_ecs_cluster.main.name}"' >> ../startecs.sh
echo 'export TASK_DEFINITION="${aws_ecs_task_definition.app.family}:${aws_ecs_task_definition.app.revision}"' >> ../startecs.sh
echo 'export SUBNETS="${join(",", data.aws_subnets.default.ids)}"' >> ../startecs.sh
echo 'export SECURITY_GROUPS="${aws_security_group.app.id}"' >> ../startecs.sh
echo 'export AWS_REGION="${var.aws_region}"' >> ../startecs.sh

echo './run_task_with_exec.sh' >> ../startecs.sh

chmod +x ../startecs.sh    
    EOT
  }
}