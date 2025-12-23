#!/bin/bash

# Update system
apt-get update -y
apt-get upgrade -y

# Install nginx
apt-get install nginx -y

# Start and enable nginx
systemctl start nginx
systemctl enable nginx

# Create web directory
mkdir -p /var/www/html

# Create HTML file using template variables
cat > /var/www/html/index.html << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <title>Simple Web Server</title>
</head>
<body>
    <h1>Welcome to ${your_name}'s Web Server</h1>
    <p>This server was provisioned using Terraform on AWS.</p>
    <p>Timestamp: ${timestamp}</p>
</body>
</html>
HTML

# Set permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Restart nginx
systemctl restart nginx

# Create a simple health check
echo "OK" > /var/www/html/health

# Log completion
echo "Web server setup completed at $(date)" >> /var/log/user-data.log