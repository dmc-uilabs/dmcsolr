#!/bin/bash

curl  "http://localhost:8983/solr/gforge_components/dataimport?command=full-import&clean=true" 
curl  "http://localhost:8983/solr/gforge_products/dataimport?command=full-import&clean=true" 
curl  "http://localhost:8983/solr/gforge_services/dataimport?command=full-import&clean=true" 
curl  "http://localhost:8983/solr/gforge_users/dataimport?command=full-import&clean=true" 
curl  "http://localhost:8983/solr/gforge_wiki/dataimport?command=full-import&clean=true" 
