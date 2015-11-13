#
# /tmp/get_bucket_files.sh
#

mkdir /tmp/solr
s3cmd -c /root/.s3cfg get --recursive --force s3://SOLR_BUCKET_BASE/SOLR_CONFIG_PATH /tmp/solr/

echo "config files are in /tmp/solr"