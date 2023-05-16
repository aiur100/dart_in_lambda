FROM dart:stable

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

RUN ls -l
# Get dependencies for the application
RUN dart pub get

# Expose port on which the app will run
EXPOSE 8080
ENV RUNNING_IN_DOCKER=true

# Run the app
CMD ["dart", "run", "./lib/api_gateway/local_api_only.dart"]
