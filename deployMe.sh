#!/bin/bash
#
# deployMe.sh for Apache Solr
#

cd /tmp
rm -fr /tmp/dmcsolr
git clone https://bitbucket.org/DigitalMfgCommons/dmcsolr.git
cd dmcsolr
# mv * ..

#
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

# Unpacking solr configuration
rm -fr /tmp/solr
mkdir /tmp/solr
cd /tmp/solr
tar xvfz /tmp/dmcsolr/files/solr.tar.gz

# download solr
echo Downloading and installing solr
rm -fr /opt/solr
mkdir /opt/solr
cd /opt/solr
wget http://archive.apache.org/dist/lucene/solr/3.6.0/apache-solr-3.6.0.tgz
tar xvzf apache-solr-3.6.0.tgz

#
echo "Moving solr.war and creating home/solr for configuration..."
/bin/cp -f /opt/solr/apache-solr-3.6.0/example/webapps/solr.war /usr/share/tomcat6/webapps/solr.war
cd /opt/solr/apache-solr-3.6.0
mkdir home
mkdir home/solr

# Moving configuration directories
mv -f /tmp/solr/LuceneSolrConfig/* /opt/solr/apache-solr-3.6.0/home/solr
mv -f /tmp/solr/TomcatConfig/server.xml /usr/share/tomcat6/conf/server.xml

# Edit components.data-config.xml
cd /tmp/dmcsolr
sed "s/SOLR_DB_DNS/$solrDbDns/" files/components.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/components/conf/data-config.xml

# Edit projects.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/projects.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/projects/conf/data-config.xml

# Edit services.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/services.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/services/conf/data-config.xml

# Edit users.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/users.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/users/conf/data-config.xml

# Edit wiki.data-config.xml
sed "s/SOLR_DB_DNS/$solrDbDns/" files/wiki.data-config.xml > /opt/solr/apache-solr-3.6.0/home/solr/wiki/conf/data-config.xml

#
echo "chowning directories"
cd /opt/solr/apache-solr-3.6.0/home/solr 
chown tomcat . components components/conf  services services/conf projects projects/conf users users/conf artifacts artifacts/conf wiki wiki/conf

#
echo "Starting Apache Tomcat" 
/etc/rc.d/init.d/tomcat6 start
chkconfig tomcat6 on

