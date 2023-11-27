FROM maven:3.8.1 as build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package -Dmaven.test.skip=true

FROM gcr.io/distroless/java:11

WORKDIR /app

EXPOSE 8080

COPY --from=build /usr/src/app/target/*.jar artifacts/app.jar

CMD ["artifacts/app.jar"]
