# The build phase for react application, tagging the phase
FROM node:16-alpine as builder 

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# To this point everything before is considered as a temp docker container
# in the main build, rightly so since we only need the build files for production.

# Last phase of docker build, pull the nginx image
FROM nginx
# Copy the build files from previous temp container phase to the standard ngnix 
# dir for serving static simple html.
COPY --from=builder /app/build /usr/share/nginx/html
