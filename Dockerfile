# Dockerfile for Core Java Project

# Use official OpenJDK image

FROM openjdk:17

# Set working directory inside container

WORKDIR /app

# Copy project files into container

COPY . .

# Compile all Java files inside src folder

RUN javac src/*.java

# Run the main class

CMD ["java", "-cp", "src", "Main"]
