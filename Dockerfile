# Base 이미지 설정 (Java 17 사용)
FROM openjdk:17-alpine

# 작업 디렉토리 설정
WORKDIR /app

# JAR 복사 및 빌드
COPY target/BookLog.jar /app/BookLog.jar

# 환경변수 파일 추가 (.env 파일 별도 관리 권장)
COPY src/main/resources/.env /app/.env

# 컨테이너 실행 시점의 명령어
ENTRYPOINT ["java","-jar","BookLog.jar"]


# 외부에 노출할 포트 설정
EXPOSE 8080
