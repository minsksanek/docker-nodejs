FROM node:10

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

# Install yarn
RUN apt-get update && apt-get install -y apt-transport-https && apt-get install -y curl && apt-get install -y gnupg2
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Install zip
RUN apt-get install -y p7zip \
    zip \
    unzip

# Install pm2
RUN npm install pm2 -g

COPY ./entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

USER node

# Install npm
RUN npm install

COPY --chown=node:node . .
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
