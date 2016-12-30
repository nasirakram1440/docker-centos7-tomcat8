# ==================================
# Tomcat8 on CentOS 7
# ==================================

- How to bake your own image from docker file
  doker build -i <image_name>:tag .

- How to run
  docker run -it <image_name>:tag /bin/bash

- How to run and start Tomcat8
  docker run -it -e TOMCAT_START=yes <image_name>:tag /bin/bash
