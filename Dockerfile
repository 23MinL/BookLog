# === Stage 1: Maven Build ===
FROM maven:3.9.0-eclipse-temurin-17 AS builder
WORKDIR /app

# pom.xml 먼저 복사 후 의존성 캐싱
COPY pom.xml .
RUN mvn dependency:go-offline

# 전체 소스 코드 복사 (mvnw 제외!)
COPY src ./src

# Maven으로 직접 빌드 (mvnw 대신 mvn 명령 사용)
RUN mvn clean package -DskipTests

# === Stage 2: Run Application ===
FROM openjdk:17-alpine
WORKDIR /app

# 생성된 JAR 파일을 복사
COPY --from=builder /app/target/*.jar /app/BookLog.jar

# 환경변수 파일 복사
COPY src/main/resources/.env /app/.env

# 포트 노출
EXPOSE 8080

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "BookLog.jar"]
