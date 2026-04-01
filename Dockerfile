# 1. fázis: Építés Maven-nel
FROM maven:3.9.6-eclipse-temurin-21 AS build
COPY . .
RUN mvn clean package -DskipTests

# 2. fázis: Futtatás
FROM eclipse-temurin:21-jdk
COPY --from=build /target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.profiles.active=dev", "-Djava.net.preferIPv4Stack=false", "-Djava.net.preferIPv6Addresses=true", "-jar", "app.war"]