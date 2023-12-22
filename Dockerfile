# Use an official Node.js runtime as a base image
FROM node:16-alpine

# Set the working directory in the container
WORKDIR /usr/src/hello-world-nextjs

# Copy package.json and package-lock.json to the working directory
COPY ./package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port that the app will run on (if applicable)
EXPOSE 3000

# Define the command to run your application
CMD ["npm", "run", "dev"]
