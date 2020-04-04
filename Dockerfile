FROM ubuntu

RUN apt update
RUN apt install -y wget gnupg2 vim 

RUN echo 'deb [arch=all] https://nx-staging.sonatype.com/repository/community-apt-hosted/ bionic main' > /etc/apt/sources.list.d/sonatype-community.list
RUN cat /etc/apt/sources.list.d/sonatype-community.list
 
RUN wget https://nx-staging.sonatype.com/repository/community-hosted/pki/deb-gpg/DEB-GPG-KEY-Sonatype.asc
RUN apt-key add DEB-GPG-KEY-Sonatype.asc 

RUN apt-get update

RUN apt-get install nexus-repository-manager -y

COPY nexus.vmoptions /opt/sonatype/nexus3/bin/nexus.vmoptions
RUN wget https://repo1.maven.org/maven2/net/java/dev/jna/jna/5.5.0/jna-5.5.0.jar -P /opt/sonatype/jna
RUN wget https://repo1.maven.org/maven2/net/java/dev/jna/jna-platform/5.5.0/jna-platform-5.5.0.jar -P /opt/sonatype/jna

CMD ["/opt/sonatype/nexus3/bin/nexus", "run"]
