# === Stage 1: Build (Maven 빌드 단계) ===
FROM maven:3.9.0-eclipse-temurin-17 AS builder
WORKDIR /app

# 먼저 pom.xml, mvnw 복사 (의존성 캐싱)
COPY pom.xml .
COPY mvnw .
RUN chmod +x mvnw

# .mvn 폴더를 완전히 제거 (중요!)
RUN rm -rf .mvn

# 전체 프로젝트 복사
COPY . .

# Maven 빌드 실행 (명시적으로 로컬 리포지토리 경로 지정하여 오류 방지)
RUN ./mvnw clean package -DskipTests -Dmaven.repo.local=/tmp/.m2/repository

# === Stage 2: Run (실행 단계) ===
FROM openjdk:17-alpine
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=builder /app/target/*.jar /app/BookLog.jar

# 환경변수 파일 복사
COPY src/main/resources/.env /app/.env

# 포트 노출
EXPOSE 8080

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "BookLog.jar"]
