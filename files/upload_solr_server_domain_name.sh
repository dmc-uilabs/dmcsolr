#
# /tmp/upload_solr_server_domain_name.sh
#

echo `curl -s http://169.254.169.254/latest/meta-data/public-hostname` > /tmp/solr_server_domain_name
s3cmd -c /root/.s3cfg put --force /tmp/solr_server_domain_name s3://SOLR_PRIVATE_BUCKET_NAME/solrServer/solr_server_domain_name
