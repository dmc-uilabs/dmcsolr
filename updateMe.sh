#!/bin/bash
cd DMC
rm -rf *
git clone https://bitbucket.org/DigitalMfgCommons/dmcrestservices.git
cd dmcrestservices
#mvn package
cp target/dmc-site-services-0.1.0.war /var/lib/tomcat7/webapps
/etc/init.d/tomcat7 restart
