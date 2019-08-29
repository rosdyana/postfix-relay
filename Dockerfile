FROM debian:buster-slim
MAINTAINER Mattias Wadman mattias.wadman@gmail.com
RUN \
  apt-get update && \
  apt-get -y --no-install-recommends install \
    python3.7 \
    nano \
    procps \
    postfix \
    mailutils \
    libsasl2-modules \
    opendkim \
    opendkim-tools \
    rsyslog && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Default config:
# Open relay, trust docker links for firewalling.
# Try to use TLS when sending to other smtp servers.
# No TLS for connecting clients, trust docker network to be safe
ENV \
  POSTFIX_myhostname=mail.rosyid.info \
  POSTFIX_mydomain=rosyid.info \
  POSTFIX_mydestination=mail.rosyid.info,localhost,localhost.rosyid.info,rosyid.info \
  POSTFIX_myorigin=rosyid.info \
  POSTFIX_mynetworks=127.0.0.0/8,[::1]/128 \
  POSTFIX_smtp_tls_security_level=may \
  POSTFIX_smtp_tls_security_level=none \
  POSTFIX_inet_interfaces=all \
  POSTFIX_milter_protocol=2 \
  POSTFIX_milter_default_action=accept \
  POSTFIX_smtpd_milters=inet:localhost:12301 \
  POSTFIX_non_smtpd_milters=inet:localhost:12301
COPY rsyslog.conf /etc/rsyslog.conf
COPY opendkim.conf /etc/opendkim.conf
RUN mkdir -p /etc/opendkim/keys/rosyid.info
COPY TrustedHosts /etc/opendkim/
COPY KeyTable /etc/opendkim/
COPY SigningTable /etc/opendkim/
# COPY /keys/rosyid.info /etc/opendkim/keys/rosyid.info/
COPY run /root/
COPY code /root/
VOLUME ["/var/lib/postfix", "/var/mail", "/var/spool/postfix", "/etc/opendkim/keys"]
EXPOSE 25 587
CMD ["/root/run"]
