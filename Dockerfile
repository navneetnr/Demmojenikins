# Multi-stage build
# Stage 1: Build the application
FROM maven:3.8-eclipse-temurin-11 AS builder

WORKDIR /app

# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:11-jre-slim

WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/demo-project-1.0-SNAPSHOT.jar app.jar

# Copy static files
COPY hello.html .

# Set the entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]
