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
Internet → AWS Security Group → EC2 Instance (Ubuntu + Nginx)
                              ↑
                       SSH Key Access
                  Private Key Authentication

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
Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

key_file = "web-server-key.pem"
private_key_file = "web-server-key.pem"
public_ip = "44.203.230.53"
ssh_command = "ssh -i web-server-key.pem ubuntu@44.203.230.53"
```
Take note of the public IP address and the ssh_command which you will use to access the VM

9. Secure the PEM key:
```bash
chmod 400 web-server-key.pem
```

10. SSH into the instance:
```bash
ssh -i web-server-key.pem ubuntu@44.203.230.53
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
http://44.203.230.53/
```
Expected output:
<img width="1914" height="617" alt="Image" src="https://github.com/user-attachments/assets/b91918b4-e9d4-46fc-8868-b5d578ae0e53"/>

13. After successful verification of the web server run:
```bash
terraform destroy --auto-approve
```
This Clean Up Resources to avoid ongoing AWS charges when testing is complete.
It terminates the EC2 instance, removes the security group, deletes the AWS key pair, and preserves your local private key file __(if you want to keep it)__