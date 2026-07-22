#!/bin/bash

set -euxo pipefail

TOKEN=$(curl -sS -X PUT \
  "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

INSTANCE_ID=$(curl -sS \
  -H "X-aws-ec2-metadata-token: $${TOKEN}" \
  http://169.254.169.254/latest/meta-data/instance-id)

AVAILABILITY_ZONE=$(curl -sS \
  -H "X-aws-ec2-metadata-token: $${TOKEN}" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone)

mkdir -p /opt/terraform-demo

cat > /opt/terraform-demo/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Terraform AWS Infrastructure</title>
</head>
<body>
  <h1>Terraform AWS Production Infrastructure</h1>
  <p>Project: ${project_name}</p>
  <p>Environment: ${environment}</p>
  <p>Instance ID: $${INSTANCE_ID}</p>
  <p>Availability Zone: $${AVAILABILITY_ZONE}</p>
</body>
</html>
EOF

cat > /etc/systemd/system/terraform-demo.service <<EOF
[Unit]
Description=Terraform Demo Web Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/terraform-demo
ExecStart=/usr/bin/python3 -m http.server 80
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable terraform-demo
systemctl start terraform-demo