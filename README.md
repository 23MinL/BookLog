# 📚 BookLog

**BookLog**는 Spring Boot와 Thymeleaf를 사용하여 도서를 검색하고 관련 정보를 확인할 수 있는 웹 애플리케이션입니다.

## 🔍 기능

- 도서 검색 (제목, 저자, 출판사 등)
- 도서 상세 정보 표시 (표지 이미지 포함)
- PostgreSQL을 활용한 데이터 저장
- Docker 컨테이너 지원

## 📂 프로젝트 구조

```
BookLog/
├── src/
│   ├── main/
│   │   ├── java/org/example/booklog/
│   │   │   ├── BookLogApplication.java
│   │   │   ├── controller/
│   │   │   │   └── BookController.java
│   │   │   ├── domain/
│   │   │   │   └── Book.java
│   │   │   └── service/
│   │   │       └── BookService.java
│   │   └── resources/
│   │       ├── templates/index.html
│   │       ├── static/css/style.css
│   │       ├── application.yml
│   │       └── .env  # 환경 변수 파일
├── Dockerfile
├── pom.xml
└── README.md
```

> ⚠️ **주의**: `.env` 파일은 민감 정보가 포함되어 있으니, 절대로 GitHub에 업로드하지 마세요 (`.gitignore`에 반드시 추가).

## 🚀 시작하기

### 1. 프로젝트 클론

```bash
git clone https://github.com/yourusername/BookLog.git
cd BookLog
```

### 2. 환경변수 설정 (`src/main/resources/.env`)

```dotenv
DB_URL=jdbc:postgresql://localhost:5432/booklog
DB_USERNAME=your_username
DB_PASSWORD=your_password
ALADIN_API_KEY=your_api_key
```

### 3. 로컬에서 실행

```bash
./mvnw clean spring-boot:run
```

브라우저에서 [http://localhost:8080](http://localhost:8080)에 접속하여 확인하세요.

## 🐳 Docker로 실행

### Dockerfile

```Dockerfile
FROM eclipse-temurin:17-jre

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
```

### 이미지 빌드

```bash
docker build -t booklog-app .
```

### 컨테이너 실행

```bash
docker run -p 8080:8080 booklog-app
```

브라우저에서 [http://localhost:8080](http://localhost:8080)으로 접속하여 사용할 수 있습니다.

## 📦 빌드 및 배포

```bash
./mvnw clean package
```

생성된 JAR 파일로 배포할 수 있습니다.

```bash
java -jar target/BookLog-0.0.1-SNAPSHOT.jar
```

## 📄 라이선스 및 저작권

본 프로젝트는 MIT 라이선스 조건에 따라 배포됩니다.

알라딘 API를 사용한 데이터의 저작권은 알라딘에 있습니다.

