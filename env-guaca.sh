LOG='script-download.log'

sudo setenforce 0

sudo touch $LOG

sudo yum install -y git docker

sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo pwd

echo "Récupération du repo"

sudo git clone https://gitlab-ops.ip-label.net/ydo/guaca.git

echo "le repos a été téléchargé"

echo "Téléchargement de docker et docker compose"

cd guaca/
sudo tar -xzvf guacamole.tar.gz
cd guacamole-docker-compose/
sudo service docker start && sudo systemctl enable docker
sudo ./prepare.sh

sudo chmod +x /usr/local/bin/docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo docker-compose up -d

echo -e "docker-compose a été installé avec succès" && sudo docker-compose --version
