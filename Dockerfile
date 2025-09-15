# Stage 1: Build the app using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /application

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY application/src ./src

# Package the application (produces target/chat-app-1.0.0.jar)
RUN mvn clean package -DskipTests

# Stage 2: Create the runtime image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /application

# Copy the jar from the build stage
COPY --from=build /application/target/chat-app-1.0.0.jar app.jar

# Expose port
EXPOSE 8080


# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
