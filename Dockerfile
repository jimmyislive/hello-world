# Run like: docker run -p 8000:8000 --name helloworld -i -t hello_world .

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Jimmy John "jimmyislive@gmail.com"

# Update the repository sources list
RUN apt-get update
RUN apt-get -y install software-properties-common python-software-properties
RUN add-apt-repository ppa:fkrull/deadsnakes
RUN apt-get update
RUN apt-get -y install python2.7
RUN apt-get -y install python-pip
RUN pip install virtualenv

# Add a deployment user for running stuff
RUN useradd -ms /bin/bash deployment
USER deployment
RUN mkdir /home/deployment/hello_world
RUN /bin/bash -c "cd /home/deployment/hello_world && virtualenv venv"

# Expose the default port
EXPOSE 8000

WORKDIR /home/deployment/hello_world

ADD --chown=deployment:deployment . .
ENV PATH "/home/deployment/hello_world/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
RUN /bin/bash -c "cd /home/deployment/hello_world && source venv/bin/activate && pip install -r requirements.txt"

RUN /bin/bash -c "cd /home/deployment/hello_world && virtualenv venv"

ENTRYPOINT /bin/bash -c "cd /home/deployment/hello_world && source venv/bin/activate && supervisord"
