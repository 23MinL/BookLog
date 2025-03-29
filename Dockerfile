# === Stage 1: Build (Maven 빌드 단계) ===
FROM maven:3.9.0-eclipse-temurin-17 AS builder
WORKDIR /app

# pom.xml과 mvnw만 복사 (캐싱)
COPY pom.xml .
COPY mvnw .
RUN chmod +x mvnw

# 전체 프로젝트 소스코드 복사
COPY . .

# 👇 핵심 수정사항: 여기서 .mvn 삭제 (프로젝트 복사 후 삭제!)
RUN rm -rf .mvn

# Maven 빌드 실행 (명시적 로컬 리포지토리 경로)
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
