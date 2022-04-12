FROM node:14-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --save

COPY . .

EXPOSE 3000

CMD [ "node" , "server.js" ]