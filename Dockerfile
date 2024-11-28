# Step 1: Use an official Node.js image as the base image
FROM node:14

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json to the container
COPY package*.json ./

# Step 4: Install project dependencies
RUN npm install
RUN npm install mysql2

# Step 5: Copy the application code
COPY app /app/app
COPY server.js /app/server.js

# Step 6: Expose the port your app will run on (8080)
EXPOSE 8080

# Step 7: Command to run the app (start the server)
CMD ["node", "server.js"]
