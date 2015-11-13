#
# deployMe.sh for Apache Solr
#

cd /tmp
git clone https://bitbucket.org/DigitalMfgCommons/dmcsolr.git
cd dmcsolr
mv * ..


#!/bin/bash
yum update -y

# install java
echo installing java
yum install -y java-1.6.0-openjdk

# install tomcat
echo installing tomcat
yum install -y tomcat6

# install git
echo installing tomcat
yum install -y git

# download solr
echo Downloading and installing solr
mkdir /opt/solr
cd /opt/solr
wget http://archive.apache.org/dist/lucene/solr/3.6.0/apache-solr-3.6.0.tgz
tar xvzf apache-solr-3.6.0.tgz

echo "Moving solr.war and creating home/solr for configuration..."
cp /opt/solr/apache-solr-3.6.0/example/webapps/solr.war /usr/share/tomcat6/webapps/solr.war
cd /opt/solr/apache-solr-3.6.0 
mkdir home
mkdir home/solr


# Edit components.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns" files/components.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/components/conf/data-config.xml

# Edit projects.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns" files/projects.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/projects/conf/data-config.xml

# Edit services.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns" files/services.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/services/conf/data-config.xml

# Edit users.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns" files/users.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/users/conf/data-config.xml

# Edit wiki.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns" files/wiki.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/wiki/conf/data-config.xml

# Edit upload_solr_server_domain_name.sh
# sed "s/SOLR_PRIVATE_BUCKET_NAME/$solrPrivateBucketName" files/upload_solr_server_domain_name.sh > /tmp/upload_solr_server_domain_name.sh

# Edit get_bucket_files.sh
# sed "s/SOLR_BUCKET_BASE/$solrBucketBase" files/upload_solr_server_domain_name.sh | "s/SOLR_CONFIG_PATH/$solrConfigpath" > /tmp/get_bucket_files.sh

# start tomcat
#service tomcat6 start

# Install SolR Configuration
echo configuring SolR
mkdir DMC
cd DMC
rm -rf *
#git clone https://bitbucket.org/DigitalMfgCommons/dmcsolr.git
git clone https://wisegb@bitbucket.org/DigitalMfgCommons/dmcsolr.git
cd dmcsolr

#cp target/dmc-site-services-0.1.0.war /var/lib/tomcat6/webapps
#service /etc/init.d/tomcat7 restart



