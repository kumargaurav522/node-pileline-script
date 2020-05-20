FROM node:10

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

#HEALTHCHECK --interval=5s --timeout=5s 
#CMD curl -f http://0.0.0.0:8081 || exit 1
EXPOSE 8081
#ENTRYPOINT ["./entrypoint.sh"]
CMD [ "node", "server.js" ]
#CMD curl -i http://0.0.0.0:8081 
