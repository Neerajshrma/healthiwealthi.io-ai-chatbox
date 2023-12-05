# Base on offical Node.js Alpine image
FROM node:alpine

COPY ./docker-entry.sh /
RUN chmod +x /docker-entry.sh

# Set working directory
WORKDIR /usr/app

# Install PM2 globally
RUN npm install --global pm2

# Copy package.json and package-lock.json before other files
# Utilise Docker cache to save re-installing dependencies if unchanged
COPY ./package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy all files
COPY ./ ./

# Expose the listening port
EXPOSE 8080

# Run container as non-root (unprivileged) user
# The node user is provided in the Node.js Alpine base image
USER node

# Run npm start script with PM2 when container starts
CMD [ "/docker-entry.sh"]