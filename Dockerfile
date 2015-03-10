FROM centos:6

# Install sshd.
RUN yum -y install openssh-server

# Install ssh
RUN yum -y install openssh-server

# Set root password to "test_password"
RUN echo "root:test_password" | chpasswd

# Generate ssh keys
RUN rm -f /etc/ssh/ssh_host_dsa_key /etc/ssh/ssh_host_rsa_key && \
        ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
        ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key


# Install RabbitMQ.
RUN \
        yum -y install logrotate && \
        rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
        yum install -y erlang && \
        rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
        rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.4/rabbitmq-server-3.1.4-1.noarch.rpm && \
        rabbitmq-plugins enable rabbitmq_management && \
        chkconfig rabbitmq-server on

# Install port forwarding tool
RUN \
        yum -y install socat

# Add start scripts
ADD run.sh /run.sh
RUN chmod +x /run.sh

ADD start_tunnel.sh /start_tunnel.sh
RUN chmod +x /start_tunnel.sh

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 22
EXPOSE 5672
# we will tunnel 5672 to 5673 using socat
EXPOSE 5673
EXPOSE 15672

CMD ["/run.sh"]