FROM openjdk:17

WORKDIR /app

COPY . /app

RUN javac src/*.java

CMD ["java", "-cp", "src", "Main"]
