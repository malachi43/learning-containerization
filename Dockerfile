FROM node:23-bookworm

WORKDIR /www/app

# Copy package.json and package-lock.json separately for better caching
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application
COPY . .

# Ensure line endings are correct
RUN sed -i 's/\r$//' scripts/start.sh

# Ensure the script is executable
RUN chmod +x scripts/start.sh

# Correct ENTRYPOINT syntax
ENTRYPOINT ["sh", "-c", "./scripts/start.sh $NODE_ENV"]
