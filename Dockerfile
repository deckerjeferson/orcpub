FROM ubuntu

RUN apt-get update
RUN apt-get install openjdk-8-jdk --assume-yes
RUN apt-get install git --assume-yes
RUN apt-get install wget --assume-yes

RUN mkdir -p /usr/local/bin/
RUN wget -P /usr/local/bin/ "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" 

RUN chmod a+x /usr/local/bin/lein
RUN export PATH=$PATH:/usr/local/bin

RUN git clone https://github.com/larrychristensen/orcpub.git

WORKDIR /orcpub 

RUN echo ";; never do this" >> project.clj
RUN echo "(require 'cemerick.pomegranate.aether)" >> project.clj
RUN echo "(cemerick.pomegranate.aether/register-wagon-factory!" >> project.clj
RUN echo " \"http\" #(org.apache.maven.wagon.providers.http.HttpWagon.))" >> project.clj

EXPOSE 3449

RUN lein uberjar
RUN ls -a

#ENTRYPOINT ["lein", "figwheel"]






