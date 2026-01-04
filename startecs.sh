#!/usr/bin/env bash
set -euo pipefail
# Start an ECS task with execute command enabled
# Usage: AWS_PROFILE=your-profile ./startecs.sh
export CLUSTER="devsvr-cluster"
export TASK_DEFINITION="devsvr-cluster-app:3"
export SUBNETS="subnet-5b308d17,subnet-af2c0ec6,subnet-8e1d73f4"
export SECURITY_GROUPS="sg-08b0db0763133d248"
export AWS_REGION="eu-west-2"
./run_task_with_exec.sh
