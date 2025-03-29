package org.example.booklog;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BookLogApplication {
    public static void main(String[] args) {
        // 현재 작업 디렉토리에서 .env 파일을 찾고, 없으면 무시합니다.
        Dotenv dotenv = Dotenv.configure()
                .directory(".")
                .ignoreIfMissing()  // .env 파일이 없으면 예외 발생을 방지
                .load();

        // .env 파일의 내용이 있으면 시스템 프로퍼티로 설정합니다.
        dotenv.entries().forEach(e -> System.setProperty(e.getKey(), e.getValue()));

        SpringApplication.run(BookLogApplication.class, args);
    }
}
