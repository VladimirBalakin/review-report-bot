FROM maven:3.6.3-jdk-11-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B -f pom.xml clean package -DskipTests

FROM openjdk:11-jdk-slim
COPY --from=build /workspace/target/*.jar app.jar
EXPOSE 9001
ENTRYPOINT ["java","-jar","app.jar"]
