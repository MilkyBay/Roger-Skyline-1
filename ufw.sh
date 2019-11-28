sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22222/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw logging low
sudo ufw reload
sudo ufw status verbose