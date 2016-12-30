#!/bin/bash

if [ "$TOMCAT_START" = 'yes' ]
then
	/opt/tomcat8/bin/catalina.sh start
fi

bash
