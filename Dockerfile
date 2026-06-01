FROM eclipse-temurin:11-jre

WORKDIR /app

COPY target/demo-project-1.0-SNAPSHOT.jar app.jar

COPY hello.html .

ENTRYPOINT ["java", "-jar", "app.jar"]