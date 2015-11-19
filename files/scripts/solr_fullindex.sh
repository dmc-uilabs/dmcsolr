#!/bin/bash

curl  "http://localhost:8983/solr/gforge_components/dataimport?command=full-import&clean=true" >> /var/solr/scripts/components_full_import.log 2>&1
curl  "http://localhost:8983/solr/gforge_products/dataimport?command=full-import&clean=true"  >> /var/solr/scripts/products_full_import.log 2>&1
curl  "http://localhost:8983/solr/gforge_services/dataimport?command=full-import&clean=true"  >> /var/solr/scripts/services_full_import.log 2>&1
curl  "http://localhost:8983/solr/gforge_users/dataimport?command=full-import&clean=true"  >> /var/solr/scripts/users_full_import.log 2>&1
curl  "http://localhost:8983/solr/gforge_wiki/dataimport?command=full-import&clean=true"  >> /var/solr/scripts/wiki_full_import.log 2>&1
