FROM tutum/centos:6.4

# Install RabbitMQ.
RUN \
        yum -y install logrotate && \
        rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm && \
        yum install -y erlang && \
        rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc && \
        rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.4/rabbitmq-server-3.1.4-1.noarch.rpm && \
        rabbitmq-plugins enable rabbitmq_management && \
        chkconfig rabbitmq-server on


# Define working directory.
WORKDIR /data

CMD /etc/init.d/rabbitmq-server start && sleep `if [[ -z "$auto_exit_timeout" ]]; then echo infinity ; else echo $auto_exit_timeout ; fi`

# Expose ports.
EXPOSE 5672
EXPOSE 15672