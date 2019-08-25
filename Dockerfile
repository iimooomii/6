FROM centos:7

RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs
RUN node -v
#yarn
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
RUN yum install -y yarn
# Set up mongodb yum repo entry
RUN echo -e "\
[mongodb-org-4.0]\n\
name=MongoDB Repository\n\
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.0/x86_64/\n\
gpgcheck=1\n\
enabled=1\n\
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc\n" >> /etc/yum.repos.d/mongodb.repo

# Install mongodb
RUN yum update -y && yum install -y mongodb-org
FROM https://github.com/iimooomii/6/httpserver/
COPY server.js
FROM https://github.com/iimooomii/6
COPY start.sh
COPY server.js https://github.com/iimooomii/6/httpserver/
server.js
COPY package.json  
COPY matches.json 
RUN go-wrapper download
RUN go-wrapper install

# Install js dependencies
RUN yarn
ENTRYPOINT ["sh", "/start.sh"]
EXPOSE 8000
CMD ["go-wrapper", "run", "-web"]
