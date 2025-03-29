# === Stage 1: Build (Maven 빌드 단계) ===
FROM maven:3.9.0-eclipse-temurin-17 AS builder
WORKDIR /app

# 필요한 파일 먼저 복사 (pom.xml, mvnw)
COPY pom.xml .
COPY mvnw .
RUN chmod +x mvnw

# (옵션) .mvn/maven.config 파일이 있다면 삭제하여 잘못된 설정 제거
RUN if [ -f .mvn/maven.config ]; then rm -f .mvn/maven.config; fi

# 전체 소스 코드 복사
COPY . .

# Maven 빌드 실행 (테스트 생략)
RUN ./mvnw clean package -DskipTests

# === Stage 2: Run (실행 단계) ===
FROM openjdk:17-alpine
WORKDIR /app

# 빌드 단계에서 생성된 JAR 파일 복사 (와일드카드를 이용하여 복사)
COPY --from=builder /app/target/*.jar /app/BookLog.jar

# 환경변수 파일 복사
COPY src/main/resources/.env /app/.env

# 외부에 노출할 포트 설정
EXPOSE 8080

# 컨테이너 실행 시 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "BookLog.jar"]
