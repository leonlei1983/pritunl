FROM centos:7

ARG GPG_KEY=7568D9BB55FF9E5287D586017AE645C0CF8E292A

ADD pritunl.repo /etc/yum.repos.d/pritunl.repo

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
  gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys ${GPG_KEY} && \
  gpg --armor --export ${GPG_KEY} > key.tmp && \
  rpm --import key.tmp && \
  rm -f key.tmp && \
  yum -y install pritunl && \
  yum clean all && \
  rm -rf /var/cache/yum

ADD pritunl.conf /etc/pritunl.conf

EXPOSE 443
CMD ["/usr/lib/pritunl/bin/pritunl", "start"]
