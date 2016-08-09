#!/bin/bash -v
#
# deployMe.sh for Apache Solr
#

# Ensure environment variables are loaded
source ~/.bashrc

# Download DMC Solr files
cd /tmp
rm -fr /tmp/dmcsolr
git clone https://bitbucket.org/DigitalMfgCommons/dmcsolr.git
cd dmcsolr


# download solr 
echo Downloading and installing solr
rm -fr /tmp/solr_install
mkdir /tmp/solr_install
cd /tmp/solr_install
wget http://archive.apache.org/dist/lucene/solr/5.3.1/solr-5.3.1.tgz >& wget_solr.log 
tar xzf solr-5.3.1.tgz solr-5.3.1/bin/install_solr_service.sh --strip-components=2

# invoke solr install script
# Defaults
# Solr installed at /opt/solr
# Solr home dir  at /var/solr/data
# The script will add user: solr
echo Invoking solr install script
sudo bash ./install_solr_service.sh  solr-5.3.1.tgz

# check solr status
echo check solr service status
sudo service solr status

# re-create solr5.tar.gz
echo "Creating solr5.tar.gz"
cd  /tmp/dmcsolr/solr5
pwd
rm -fr ../files/solr5.tar.gz
tar acf ../files/solr5.tar.gz .
ls -l /tmp/dmcsolr/files/solr5.tar.gz

# Unpacking solr configuration
rm -fr /tmp/solr
mkdir /tmp/solr
cd /tmp/solr
tar xfz /tmp/dmcsolr/files/solr5.tar.gz

# Log in as solr user
echo chown directories to solr
sudo chown -R solr /tmp/solr
sudo chown -R solr /tmp/dmcsolr

# Moving configuration directories to solr home
echo moving DMC solr configuration files to solr home /var/solr/data
sudo -u solr mv -f /tmp/solr/LuceneSolrConfig/* /var/solr/data/.

# Edit components.data-config.xml
echo "Editing SolR data configurations to use solrDbDns=localhost"
cd /tmp/dmcsolr
sudo -u solr -E sed -e "s/SOLR_DB_DNS/localhost/" -e "s/SOLR_DB_PORT/5432/" files/components.data-config.xml > /var/solr/data/gforge/components/conf/data-config.xml

# Edit companies.data-config.xml
sudo -u solr -E sed -e "s/SOLR_DB_DNS/localhost/" -e "s/SOLR_DB_PORT/5432/" files/companies.data-config.xml > /var/solr/data/gforge/companies/conf/data-config.xml

# Edit projects.data-config.xml
sudo -u solr -E sed -e "s/SOLR_DB_DNS/localhost/" -e "s/SOLR_DB_PORT/5432/" files/projects.data-config.xml > /var/solr/data/gforge/projects/conf/data-config.xml

# Edit services.data-config.xml
sudo -u solr -E sed -e "s/SOLR_DB_DNS/localhost/" -e "s/SOLR_DB_PORT/5432/" files/services.data-config.xml > /var/solr/data/gforge/services/conf/data-config.xml

# Edit users.data-config.xml
sudo -u solr -E sed -e "s/SOLR_DB_DNS/localhost/" -e "s/SOLR_DB_PORT/5432/" files/users.data-config.xml > /var/solr/data/gforge/users/conf/data-config.xml

# Edit wiki.data-config.xml
sudo -u solr -E sed -e "s/SOLR_DB_DNS/localhost/" -e "s/SOLR_DB_PORT/5432/" files/wiki.data-config.xml > /var/solr/data/gforge/wiki/conf/data-config.xml

# Install cron and scripts
sudo yum install cronie -y
sudo -u solr cp -r files/scripts  /var/solr
sudo -u solr chmod +x /var/solr/scripts/*.sh
sudo -u solr crontab files/scripts/cron_solr_index
sudo -u solr crontab -l

# Ensure cron is running
sudo service crond start
sudo service crond status

# Restart solr
#echo restart solr
#sudo service solr restart

# check solr status
#echo check solr status
#sudo service solr status
