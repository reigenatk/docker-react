# production file

#build phase
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
#run phase
FROM nginx
# move the build folders' contents into the required directory
# for nginx to serve it up. Now if we build this image
# using 'docker build .' and route the ports it will also work 
# just as before with npm start 

# tell AWS elastic beanstalk to map to port 80
EXPOSE 80 
COPY --from=0 /app/build /usr/share/nginx/html