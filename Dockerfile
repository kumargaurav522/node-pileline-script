FROM node

RUN apt-get update && apt-get upgrade -y \
    && apt-get clean && apt-get install curl -y

RUN mkdir /app
WORKDIR /app

COPY package.json /app/
RUN npm install --only=production

COPY src /app/src

EXPOSE 3000

CMD [ "npm", "start" ]

