#!/bin/bash -v
#
# deployMe.sh for Apache Solr
#

# Ensure environment variables are read
source ~/.bashrc

#
sudo yum update -y

# install java
echo installing java 8
sudo yum install -y java-1.8.0-openjdk.x86_64

# install git
echo installing git
sudo yum install -y git

# Download DMC Solr files
cd /tmp
rm -fr /tmp/dmcsolr
git clone https://bitbucket.org/DigitalMfgCommons/dmcsolr.git
cd dmcsolr

# Unpacking solr configuration
rm -fr /tmp/solr
mkdir /tmp/solr
cd /tmp/solr
tar xvfz /tmp/dmcsolr/files/solr5.tar.gz

# download solr 
echo Downloading and installing solr
rm -fr /tmp/solr_install
mkdir /tmp/solr_install
cd /tmp/solr_install
wget http://archive.apache.org/dist/lucene/solr/5.3.1/solr-5.3.1.tgz 
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

# Log in as solr user
echo configuring solr for gforge
sudo su - solr

# Moving configuration directories to solr home
echo moving DMC solr configuration files to solr home /var/solr/data
sudo mv -f /tmp/solr/LuceneSolrConfig/* /var/solr/data

# Edit components.data-config.xml
echo "Editing SolR data configurations to use solrDbDns=$solrDbDns"
cd /tmp/dmcsolr
sed "s/SOLR_DB_DNS/$solrDbDns/" files/components.data-config.xml > /var/solr/data/gforge/components/conf/data-config.xml

# Edit projects.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/projects.data-config.xml > /var/solr/data/gforge/projects/conf/data-config.xml

# Edit services.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/services.data-config.xml > /var/solr/data/gforge/services/conf/data-config.xml

# Edit users.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/users.data-config.xml > /var/solr/data/gforge/users/conf/data-config.xml

# Edit wiki.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/wiki.data-config.xml > /var/solr/data/gforge/wiki/conf/data-config.xml

# Exit as user solr
exit

# Restart solr
echo restart solr
sudo service solr restart

# check solr status
echo check solr status
sudo service solr status
