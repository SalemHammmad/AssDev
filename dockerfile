FROM maven:3.8.4-openjdk-8-slim AS build
WORKDIR /app
COPY pom.xml .

COPY src ./src
RUN mvn -B -DskipTests clean package


FROM openjdk:8-jdk-alpine
COPY --from=build /app/target/*.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]