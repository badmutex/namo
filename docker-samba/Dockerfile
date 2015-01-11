FROM phusion/baseimage

RUN apt-get -yqq update && apt-get -yqq install samba samba-client

VOLUME /etc/passwd
VOLUME /etc/group
VOLUME /share
VOLUME /etc/samba

ADD ./entry.sh /bin/entry.sh

EXPOSE 139 445
ENTRYPOINT ["/bin/entry.sh"]
