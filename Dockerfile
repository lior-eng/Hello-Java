# Stage 1: build the application
FROM maven:3.6.0-jdk-8-slim AS build
WORKDIR /app
COPY . /app
RUN mvn verify

# Stage 2: run the application
FROM openjdk:8-jre-slim
WORKDIR /app

# Copy the entry-point script
COPY entry-point.sh ./
RUN chmod +x entry-point.sh

# Copy the built JAR file from the build stage
COPY --from=build /app/target/hello-java.jar /app

# Run the entry-point script
ENTRYPOINT ["./entry-point.sh"]

