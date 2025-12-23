# Terraform AWS Web Server Deployment

### Project Overview
This Terraform project provisions a secure web server on AWS that serves an HTML page displaying my full name. The infrastructure is fully managed as code using Infrastructure as Code (IaC) principles.

### Objectives
- Provision a functional web server on AWS

- Serve a simple HTML page displaying your full name

- Implement security best practices

- Provide reproducible infrastructure deployment

- Ensure clean resource management


## 📋 Features
- Deploys Ubuntu web server with Nginx
- Auto-generates SSH key pair
- Configures security group (HTTP:80, SSH:22)
- Custom HTML page with your name and timestamp
- Automatic user-data configuration

## Architecture
```text
Internet → AWS Security Group → EC2 Instance (Ubuntu + Nginx)
                              ↑
                       SSH Key Access
                  Private Key Authentication
```

## Project Structure:
```text
.
├── main.tf              # Main infrastructure configuration
├── variables.tf         # Input variables with defaults
├── outputs.tf          # Output values for easy access
├── providers.tf        # Terraform provider configuration
├── user-data.tpl       # Cloud-init script template
├── README.md           # This documentation
├── terraform.tfvars    # Variable values (gitignored)
└── .gitignore
```

## Deployment commands
1. First ensure you have AWS CLI downloaded and configued
2. Get the AWS Access Key ID, AWS Secret Access Key
3. Run ```aws configure``` then supply all that was asked for such as:
    - AWS Access Key ID
    - AWS Secret Access Key
    - region = "us-east-1"
    - output = "json'
4. Initialize terrafom running this command:
```bash
terraform init
```
5. Validates the syntax of Terraform configuration files using this command:
```bash
terraform validate
```
This checks for basic configuration errors

6. Review Execution Plan
```bash
terraform plan
```
Expected Output:
```text
data.aws_vpc.default: Reading...
data.aws_vpc.default: Read complete after 8s [id=vpc-089845d84ae01b5c0]
data.aws_subnets.default: Reading...
data.aws_subnets.default: Read complete after 0s [id=us-east-1]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.web_server will be created
  + resource "aws_instance" "web_server" {
      + ami                                  = "ami-0ecb62995f68bb549"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "web-server-key"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-001b95ace57b5677d"
      + tags                                 = {
          + "CreatedBy" = "David Abayomi-George"
          + "Name"      = "web-server"
        }
      + tags_all                             = {
          + "CreatedBy" = "David Abayomi-George"
          + "Name"      = "web-server"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_key_pair.web_key will be created
  + resource "aws_key_pair" "web_key" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "web-server-key"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + tags_all        = (known after apply)
    }

  # aws_security_group.web_sg will be created
  + resource "aws_security_group" "web_sg" {
      + arn                    = (known after apply)
      + description            = "Allow HTTP and SSH"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "web-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "web-sg"
        }
      + tags_all               = {
          + "Name" = "web-sg"
        }
      + vpc_id                 = "vpc-089845d84ae01b5c0"
    }

  # local_file.private_key will be created
  + resource "local_file" "private_key" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "web-server-key.pem"
      + id                   = (known after apply)
    }

  # tls_private_key.web_key will be created
  + resource "tls_private_key" "web_key" {
      + algorithm                     = "RSA"
      + ecdsa_curve                   = "P224"
      + id                            = (known after apply)
      + private_key_openssh           = (sensitive value)
      + private_key_pem               = (sensitive value)
      + private_key_pem_pkcs8         = (sensitive value)
      + public_key_fingerprint_md5    = (known after apply)
      + public_key_fingerprint_sha256 = (known after apply)
      + public_key_openssh            = (known after apply)
      + public_key_pem                = (known after apply)
      + rsa_bits                      = 4096
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + key_file         = "web-server-key.pem"
  + private_key_file = "web-server-key.pem"
  + public_ip        = (known after apply)
  + ssh_command      = (known after apply)
```
**What this does:**

- Creates an execution plan without making changes

- Shows what resources will be created, modified, or destroyed

- Calculates dependencies between resources

- Estimates costs and resource usage

- Highlights security group rules and access permissions

7. Apply the Configuration:
```bash
terraform apply --auto-approve
```
**What this does:**

- Provisions all resources defined in the configuration

- Creates the EC2 instance with Ubuntu

- Sets up security group with HTTP and SSH access

- Generates and saves SSH key pair

- Configures Nginx web server with your name

- Applies tags with your name to all resources

8. Expected outputs after applying:
```text
data.aws_vpc.default: Reading...
data.aws_vpc.default: Read complete after 8s [id=vpc-089845d84ae01b5c0]
data.aws_subnets.default: Reading...
data.aws_subnets.default: Read complete after 1s [id=us-east-1]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.web_server will be created
  + resource "aws_instance" "web_server" {
      + ami                                  = "ami-0ecb62995f68bb549"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = true
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.small"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "web-server-key"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-001b95ace57b5677d"
      + tags                                 = {
          + "CreatedBy" = "David Abayomi-George"
          + "Name"      = "web-server"
        }
      + tags_all                             = {
          + "CreatedBy" = "David Abayomi-George"
          + "Name"      = "web-server"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)
    }

  # aws_key_pair.web_key will be created
  + resource "aws_key_pair" "web_key" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "web-server-key"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (known after apply)
      + tags_all        = (known after apply)
    }

  # aws_security_group.web_sg will be created
  + resource "aws_security_group" "web_sg" {
      + arn                    = (known after apply)
      + description            = "Allow HTTP and SSH"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "web-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "web-sg"
        }
      + tags_all               = {
          + "Name" = "web-sg"
        }
      + vpc_id                 = "vpc-089845d84ae01b5c0"
    }

  # local_file.private_key will be created
  + resource "local_file" "private_key" {
      + content              = (sensitive value)
      + content_base64sha256 = (known after apply)
      + content_base64sha512 = (known after apply)
      + content_md5          = (known after apply)
      + content_sha1         = (known after apply)
      + content_sha256       = (known after apply)
      + content_sha512       = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "web-server-key.pem"
      + id                   = (known after apply)
    }

  # tls_private_key.web_key will be created
  + resource "tls_private_key" "web_key" {
      + algorithm                     = "RSA"
      + ecdsa_curve                   = "P224"
      + id                            = (known after apply)
      + private_key_openssh           = (sensitive value)
      + private_key_pem               = (sensitive value)
      + private_key_pem_pkcs8         = (sensitive value)
      + public_key_fingerprint_md5    = (known after apply)
      + public_key_fingerprint_sha256 = (known after apply)
      + public_key_openssh            = (known after apply)
      + public_key_pem                = (known after apply)
      + rsa_bits                      = 4096
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + key_file         = "web-server-key.pem"
  + private_key_file = "web-server-key.pem"
  + public_ip        = (known after apply)
  + ssh_command      = (known after apply)
tls_private_key.web_key: Creating...
tls_private_key.web_key: Creation complete after 3s [id=227e97708a4639aa0bfab6951555cdb47e2cbd5e]
local_file.private_key: Creating...
local_file.private_key: Creation complete after 0s [id=61270e8a2b8730d3f0f49da3d6c7ce8b209c4b01]
aws_key_pair.web_key: Creating...
aws_security_group.web_sg: Creating...
aws_key_pair.web_key: Creation complete after 3s [id=web-server-key]
aws_security_group.web_sg: Creation complete after 8s [id=sg-0070eff032f23bea5]
aws_instance.web_server: Creating...
aws_instance.web_server: Still creating... [00m10s elapsed]
aws_instance.web_server: Creation complete after 17s [id=i-0ff8025c7af7be32a]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

key_file = "web-server-key.pem"
private_key_file = "web-server-key.pem"
public_ip = "34.237.222.52"
ssh_command = "ssh -i web-server-key.pem ubuntu@34.237.222.52"
```
Take note of the public IP address and the ssh_command which you will use to access the VM

9. Secure the PEM key:
```bash
chmod 400 web-server-key.pem
```
Expected Output:
```text
ls -la web-server-key.pem
-r-------- 1 david david 3243 Dec 23 20:29 web-server-key.pem
```

10. SSH into the instance:
```bash
ssh -i web-server-key.pem ubuntu@34.237.222.52
```
Expected Output
```text
ssh -i web-server-key.pem ubuntu@34.237.222.52
The authenticity of host '34.237.222.52 (34.237.222.52)' can't be established.
ED25519 key fingerprint is SHA256:g6qlmKHtbITe64aCjPh1+gZgK5V+SRW5uli43Fqgf8s.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '34.237.222.52' (ED25519) to the list of known hosts.
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.14.0-1015-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Tue Dec 23 19:30:33 UTC 2025

  System load:  0.62              Temperature:           -273.1 C
  Usage of /:   30.8% of 6.71GB   Processes:             126
  Memory usage: 16%               Users logged in:       0
  Swap usage:   0%                IPv4 address for ens5: 172.31.8.0

Expanded Security Maintenance for Applications is not enabled.

74 updates can be applied immediately.
28 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```

11. Once gaining access, check NGINX server status:
```bash
sudo systemctl status nginx
```
Expected output:
```text
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: active (running) since Tue 2025-12-23 18:14:07 UTC; 1min 5s ago
       Docs: man:nginx(8)
    Process: 8718 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 8720 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 8721 (nginx)
      Tasks: 3 (limit: 2204)
     Memory: 2.3M (peak: 2.5M)
        CPU: 20ms
     CGroup: /system.slice/nginx.service
             ├─8721 "nginx: master process /usr/sbin/nginx -g daemon on; master_process on;"
             ├─8722 "nginx: worker process"
             └─8723 "nginx: worker process"
```

12. Visit the website using the IP address supplied:
```text
http://34.237.222.52/
```
Expected output:
<img width="1914" height="617" alt="Image" src="https://github.com/user-attachments/assets/b91918b4-e9d4-46fc-8868-b5d578ae0e53"/>

13. Exit the instance
```bash
exit
```

14. After successful verification of the web server run:
```bash
terraform destroy --auto-approve
```

Expected Output:
```text
tls_private_key.web_key: Refreshing state... [id=227e97708a4639aa0bfab6951555cdb47e2cbd5e]
local_file.private_key: Refreshing state... [id=61270e8a2b8730d3f0f49da3d6c7ce8b209c4b01]
data.aws_vpc.default: Reading...
aws_key_pair.web_key: Refreshing state... [id=web-server-key]
data.aws_vpc.default: Read complete after 3s [id=vpc-089845d84ae01b5c0]
data.aws_subnets.default: Reading...
aws_security_group.web_sg: Refreshing state... [id=sg-0070eff032f23bea5]
data.aws_subnets.default: Read complete after 1s [id=us-east-1]
aws_instance.web_server: Refreshing state... [id=i-0ff8025c7af7be32a]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.web_server will be destroyed
  - resource "aws_instance" "web_server" {
      - ami                                  = "ami-0ecb62995f68bb549" -> null
      - arn                                  = "arn:aws:ec2:us-east-1:767398149006:instance/i-0ff8025c7af7be32a" -> null
      - associate_public_ip_address          = true -> null
      - availability_zone                    = "us-east-1c" -> null
      - cpu_core_count                       = 1 -> null
      - cpu_threads_per_core                 = 2 -> null
      - disable_api_stop                     = false -> null
      - disable_api_termination              = false -> null
      - ebs_optimized                        = false -> null
      - get_password_data                    = false -> null
      - hibernation                          = false -> null
      - id                                   = "i-0ff8025c7af7be32a" -> null
      - instance_initiated_shutdown_behavior = "stop" -> null
      - instance_state                       = "running" -> null
      - instance_type                        = "t3.small" -> null
      - ipv6_address_count                   = 0 -> null
      - ipv6_addresses                       = [] -> null
      - key_name                             = "web-server-key" -> null
      - monitoring                           = false -> null
      - placement_partition_number           = 0 -> null
      - primary_network_interface_id         = "eni-073c55cdb1cbefca6" -> null
      - private_dns                          = "ip-172-31-8-0.ec2.internal" -> null
      - private_ip                           = "172.31.8.0" -> null
      - public_dns                           = "ec2-34-237-222-52.compute-1.amazonaws.com" -> null
      - public_ip                            = "34.237.222.52" -> null
      - secondary_private_ips                = [] -> null
      - security_groups                      = [
          - "web-sg",
        ] -> null
      - source_dest_check                    = true -> null
      - subnet_id                            = "subnet-001b95ace57b5677d" -> null
      - tags                                 = {
          - "CreatedBy" = "David Abayomi-George"
          - "Name"      = "web-server"
        } -> null
      - tags_all                             = {
          - "CreatedBy" = "David Abayomi-George"
          - "Name"      = "web-server"
        } -> null
      - tenancy                              = "default" -> null
      - user_data                            = "f40e881df7ba7a6cfe48ece8172368a75a475f60" -> null
      - user_data_replace_on_change          = false -> null
      - vpc_security_group_ids               = [
          - "sg-0070eff032f23bea5",
        ] -> null
        # (7 unchanged attributes hidden)

      - capacity_reservation_specification {
          - capacity_reservation_preference = "open" -> null
        }

      - cpu_options {
          - core_count       = 1 -> null
          - threads_per_core = 2 -> null
            # (1 unchanged attribute hidden)
        }

      - credit_specification {
          - cpu_credits = "unlimited" -> null
        }

      - enclave_options {
          - enabled = false -> null
        }

      - maintenance_options {
          - auto_recovery = "default" -> null
        }

      - metadata_options {
          - http_endpoint               = "enabled" -> null
          - http_protocol_ipv6          = "disabled" -> null
          - http_put_response_hop_limit = 2 -> null
          - http_tokens                 = "required" -> null
          - instance_metadata_tags      = "disabled" -> null
        }

      - private_dns_name_options {
          - enable_resource_name_dns_a_record    = false -> null
          - enable_resource_name_dns_aaaa_record = false -> null
          - hostname_type                        = "ip-name" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - device_name           = "/dev/sda1" -> null
          - encrypted             = false -> null
          - iops                  = 3000 -> null
          - tags                  = {} -> null
          - tags_all              = {} -> null
          - throughput            = 125 -> null
          - volume_id             = "vol-01becf3380f0f57dc" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp3" -> null
            # (1 unchanged attribute hidden)
        }
    }

  # aws_key_pair.web_key will be destroyed
  - resource "aws_key_pair" "web_key" {
      - arn             = "arn:aws:ec2:us-east-1:767398149006:key-pair/web-server-key" -> null
      - fingerprint     = "9e:4a:e9:17:76:90:4e:01:53:d2:38:be:0a:aa:96:ba" -> null
      - id              = "web-server-key" -> null
      - key_name        = "web-server-key" -> null
      - key_pair_id     = "key-0910d4115671e630b" -> null
      - key_type        = "rsa" -> null
      - public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDaU7Jk6Ky7wMPlO3ReZAtdQgwjf77Dzi+Z8849L4m2IK9D48bfuYvIUhyILk4dJNZCGhnGg1k9L0LvBYE76xMJ2dvHjisdzL8pgPzu+GYyVRzc/Mg/0Kzpv5fmaOMFxCL2Gl/lF+1vNjfp26XKC0eng60U7OXSbvAkMPthXlwKbwtbxo9yKNaOPJJr1HwNL2tMXPXu+tk5ltz+rTtDQgFcvUQPUayXcGDKeftwp1XuIfPFGPEfTRVMgEr8z6BGfKdjvG3Iw8nACn6nAsHl7ZpTRqAvmqBvDBkWY6dp2kPdzvl0CGgA6+mipaiC3m2UH+SPL1Wh1w0bbyW/DiVj6Tes0r7Ko+QZmjoIjSz30oM+fkh9mvTyz+P+Y5lA45awf0TlzDf9jN09paaiQg4Vjd4kxJkjBaHB8S4Fcd+uIIqzoyaYh6HYNrobtnuK3QLlV79Gqy6ytNbTh7mMVUsjpdV799WOv01EnF8kR+203vRXIfcQJ6q/JgPCcTSXHUxdWZSoAeehkkluHCUYBB0TPeF25yrXNJJUdSZIlxQEIJK/4oUGxZyh9A5o289wSCF3ZPPfhrITfxfDUmaubYFLw8GZtRiEwsh/pIJH0Y02YNU1MapgbLARTXstWZ/9CLERjOilCBNbA3kvTUFLZijF1ALE2E/oCUxsslxYbLUtnOby7w==" -> null
      - tags            = {} -> null
      - tags_all        = {} -> null
        # (1 unchanged attribute hidden)
    }

  # aws_security_group.web_sg will be destroyed
  - resource "aws_security_group" "web_sg" {
      - arn                    = "arn:aws:ec2:us-east-1:767398149006:security-group/sg-0070eff032f23bea5" -> null
      - description            = "Allow HTTP and SSH" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ] -> null
      - id                     = "sg-0070eff032f23bea5" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "HTTP"
              - from_port        = 80
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 80
            },
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = "SSH"
              - from_port        = 22
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "tcp"
              - security_groups  = []
              - self             = false
              - to_port          = 22
            },
        ] -> null
      - name                   = "web-sg" -> null
      - owner_id               = "767398149006" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "web-sg"
        } -> null
      - tags_all               = {
          - "Name" = "web-sg"
        } -> null
      - vpc_id                 = "vpc-089845d84ae01b5c0" -> null
        # (1 unchanged attribute hidden)
    }

  # local_file.private_key will be destroyed
  - resource "local_file" "private_key" {
      - content              = (sensitive value) -> null
      - content_base64sha256 = "mIxWz2YQ35/IJRzhpjUc24YiDHjySMtnOITESaSNa8M=" -> null
      - content_base64sha512 = "TerR197bpL7S21V4Ji1q06ddbrKySp5jS7d/+wCs3vXJJVJPXZiyYgU7cdBqXcBxZ0S3unEPa1Emd7TegqhUiQ==" -> null
      - content_md5          = "6aebb01afd49df012970bda73001220e" -> null
      - content_sha1         = "61270e8a2b8730d3f0f49da3d6c7ce8b209c4b01" -> null
      - content_sha256       = "988c56cf6610df9fc8251ce1a6351cdb86220c78f248cb673884c449a48d6bc3" -> null
      - content_sha512       = "4dead1d7dedba4bed2db5578262d6ad3a75d6eb2b24a9e634bb77ffb00acdef5c925524f5d98b262053b71d06a5dc0716744b7ba710f6b512677b4de82a85489" -> null
      - directory_permission = "0777" -> null
      - file_permission      = "0777" -> null
      - filename             = "web-server-key.pem" -> null
      - id                   = "61270e8a2b8730d3f0f49da3d6c7ce8b209c4b01" -> null
    }

  # tls_private_key.web_key will be destroyed
  - resource "tls_private_key" "web_key" {
      - algorithm                     = "RSA" -> null
      - ecdsa_curve                   = "P224" -> null
      - id                            = "227e97708a4639aa0bfab6951555cdb47e2cbd5e" -> null
      - private_key_openssh           = (sensitive value) -> null
      - private_key_pem               = (sensitive value) -> null
      - private_key_pem_pkcs8         = (sensitive value) -> null
      - public_key_fingerprint_md5    = "d2:e0:22:b5:8f:88:09:53:68:27:61:fc:c1:77:4a:8b" -> null
      - public_key_fingerprint_sha256 = "SHA256:WP5qWZn8Xx3Wen0rV3Mfc5rthxkYESUGH0wd13onNO0" -> null
      - public_key_openssh            = <<-EOT
            ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDaU7Jk6Ky7wMPlO3ReZAtdQgwjf77Dzi+Z8849L4m2IK9D48bfuYvIUhyILk4dJNZCGhnGg1k9L0LvBYE76xMJ2dvHjisdzL8pgPzu+GYyVRzc/Mg/0Kzpv5fmaOMFxCL2Gl/lF+1vNjfp26XKC0eng60U7OXSbvAkMPthXlwKbwtbxo9yKNaOPJJr1HwNL2tMXPXu+tk5ltz+rTtDQgFcvUQPUayXcGDKeftwp1XuIfPFGPEfTRVMgEr8z6BGfKdjvG3Iw8nACn6nAsHl7ZpTRqAvmqBvDBkWY6dp2kPdzvl0CGgA6+mipaiC3m2UH+SPL1Wh1w0bbyW/DiVj6Tes0r7Ko+QZmjoIjSz30oM+fkh9mvTyz+P+Y5lA45awf0TlzDf9jN09paaiQg4Vjd4kxJkjBaHB8S4Fcd+uIIqzoyaYh6HYNrobtnuK3QLlV79Gqy6ytNbTh7mMVUsjpdV799WOv01EnF8kR+203vRXIfcQJ6q/JgPCcTSXHUxdWZSoAeehkkluHCUYBB0TPeF25yrXNJJUdSZIlxQEIJK/4oUGxZyh9A5o289wSCF3ZPPfhrITfxfDUmaubYFLw8GZtRiEwsh/pIJH0Y02YNU1MapgbLARTXstWZ/9CLERjOilCBNbA3kvTUFLZijF1ALE2E/oCUxsslxYbLUtnOby7w==
        EOT -> null
      - public_key_pem                = <<-EOT
            -----BEGIN PUBLIC KEY-----
            MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2lOyZOisu8DD5Tt0XmQL
            XUIMI3++w84vmfPOPS+JtiCvQ+PG37mLyFIciC5OHSTWQhoZxoNZPS9C7wWBO+sT
            Cdnbx44rHcy/KYD87vhmMlUc3PzIP9Cs6b+X5mjjBcQi9hpf5RftbzY36dulygtH
            p4OtFOzl0m7wJDD7YV5cCm8LW8aPcijWjjySa9R8DS9rTFz17vrZOZbc/q07Q0IB
            XL1ED1Gsl3Bgynn7cKdV7iHzxRjxH00VTIBK/M+gRnynY7xtyMPJwAp+pwLB5e2a
            U0agL5qgbwwZFmOnadpD3c75dAhoAOvpoqWogt5tlB/kjy9VodcNG28lvw4lY+k3
            rNK+yqPkGZo6CI0s99KDPn5IfZr08s/j/mOZQOOWsH9E5cw3/YzdPaWmokIOFY3e
            JMSZIwWhwfEuBXHfriCKs6MmmIeh2Da6G7Z7it0C5Ve/RqsusrTW04e5jFVLI6XV
            e/fVjr9NRJxfJEfttN70VyH3ECeqvyYDwnE0lx1MXVmUqAHnoZJJbhwlGAQdEz3h
            ducq1zSSVHUmSJcUBCCSv+KFBsWcofQOaNvPcEghd2Tz34ayE38Xw1Jmrm2BS8PB
            mbUYhMLIf6SCR9GNNmDVNTGqYGywEU17LVmf/QixEYzopQgTWwN5L01BS2YoxdQC
            xNhP6AlMbLJcWGy1LZzm8u8CAwEAAQ==
            -----END PUBLIC KEY-----
        EOT -> null
      - rsa_bits                      = 4096 -> null
    }

Plan: 0 to add, 0 to change, 5 to destroy.

Changes to Outputs:
  - key_file         = "web-server-key.pem" -> null
  - private_key_file = "web-server-key.pem" -> null
  - public_ip        = "34.237.222.52" -> null
  - ssh_command      = "ssh -i web-server-key.pem ubuntu@34.237.222.52" -> null
local_file.private_key: Destroying... [id=61270e8a2b8730d3f0f49da3d6c7ce8b209c4b01]
local_file.private_key: Destruction complete after 0s
aws_instance.web_server: Destroying... [id=i-0ff8025c7af7be32a]
aws_instance.web_server: Still destroying... [id=i-0ff8025c7af7be32a, 00m10s elapsed]
aws_instance.web_server: Still destroying... [id=i-0ff8025c7af7be32a, 00m20s elapsed]
aws_instance.web_server: Still destroying... [id=i-0ff8025c7af7be32a, 00m30s elapsed]
aws_instance.web_server: Still destroying... [id=i-0ff8025c7af7be32a, 00m40s elapsed]
aws_instance.web_server: Still destroying... [id=i-0ff8025c7af7be32a, 00m50s elapsed]
aws_instance.web_server: Destruction complete after 54s
aws_key_pair.web_key: Destroying... [id=web-server-key]
aws_security_group.web_sg: Destroying... [id=sg-0070eff032f23bea5]
aws_key_pair.web_key: Destruction complete after 0s
tls_private_key.web_key: Destroying... [id=227e97708a4639aa0bfab6951555cdb47e2cbd5e]
tls_private_key.web_key: Destruction complete after 0s
aws_security_group.web_sg: Destruction complete after 2s

Destroy complete! Resources: 5 destroyed.
```
This Clean Up Resources to avoid ongoing AWS charges when testing is complete.
It terminates the EC2 instance, removes the security group, deletes the AWS key pair, and preserves your local private key file __(if you want to keep it)__