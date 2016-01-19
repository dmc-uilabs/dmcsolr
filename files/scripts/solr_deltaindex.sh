#!/bin/bash

curl  "http://localhost:8983/solr/gforge_components/dataimport?command=delta-import"
curl  "http://localhost:8983/solr/gforge_projects/dataimport?command=delta-import"
curl  "http://localhost:8983/solr/gforge_services/dataimport?command=delta-import"
curl  "http://localhost:8983/solr/gforge_users/dataimport?command=delta-import"
curl  "http://localhost:8983/solr/gforge_wiki/dataimport?command=delta-import"
