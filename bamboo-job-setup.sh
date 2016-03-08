
#stop solr if it is running
echo "stop solr if running"
sudo service solr stop

#extract LuceneSolrConfig and copy to correct location
echo "extract solr config from tar and copy to /var/solr"
mkdir lucene-setup
cd lucene-setup
tar xvfz ../files/solr5.tar.gz
sudo -u solr rm -rf /var/solr/data/gforge
sudo -u solr cp -r -f LuceneSolrConfig/* /var/solr/data/.
cd ..
rm -rf lucene-setup

#remove old files
echo "remove old copies of files if they exist"
sudo -u solr rm -f /var/solr/data/gforge/components/conf/data-config.xml
sudo -u solr rm -f /var/solr/data/gforge/projects/conf/data-config.xml
sudo -u solr rm -f /var/solr/data/gforge/services/conf/data-config.xml
sudo -u solr rm -f /var/solr/data/gforge/users/conf/data-config.xml
sudo -u solr rm -f /var/solr/data/gforge/wiki/conf/data-config.xml

#fix latest files and copy to /var/solr/data/gforge where they are expected to be
echo "fix latest version of files and put in /var/solr"
sed "s/SOLR_DB_DNS/localhost/" files/components.data-config.xml > files/tmp.components.data-config.xml
sudo -u solr cp files/tmp.components.data-config.xml /var/solr/data/gforge/components/conf/data-config.xml
rm files/tmp.components.data-config.xml

# Edit projects.data-config.xml
sed "s/SOLR_DB_DNS/localhost/" files/projects.data-config.xml > files/tmp.projects.data-config.xml
sudo -u solr cp files/tmp.projects.data-config.xml /var/solr/data/gforge/projects/conf/data-config.xml
rm files/tmp.projects.data-config.xml

# Edit services.data-config.xml
sed "s/SOLR_DB_DNS/localhost/" files/services.data-config.xml > files/tmp.services.data-config.xml
sudo -u solr cp files/tmp.services.data-config.xml /var/solr/data/gforge/services/conf/data-config.xml
rm files/tmp.services.data-config.xml

# Edit users.data-config.xml
sed "s/SOLR_DB_DNS/localhost/" files/users.data-config.xml > files/tmp.users.data-config.xml
sudo -u solr cp files/tmp.users.data-config.xml /var/solr/data/gforge/users/conf/data-config.xml
rm files/tmp.users.data-config.xml

# Edit wiki.data-config.xml
sed "s/SOLR_DB_DNS/localhost/" files/wiki.data-config.xml > files/tmp.wiki.data-config.xml
sudo -u solr cp files/tmp.wiki.data-config.xml /var/solr/data/gforge/wiki/conf/data-config.xml
rm files/tmp.wiki.data-config.xml

# copy scripts - probably not so critical for bamboo job because it doesn't run this long
echo "copy scripts and make them executable"
sudo -u solr cp -r files/scripts  /var/solr
sudo -u solr chmod +x /var/solr/scripts/*.sh

# Restart solr
echo restart solr
sudo service solr restart

# check solr status
echo check solr status
sudo service solr status

echo "reindex solr"
sudo -u solr /var/solr/scripts/solr_fullindex.sh
