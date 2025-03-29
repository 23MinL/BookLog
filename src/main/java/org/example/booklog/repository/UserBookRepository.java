package org.example.booklog.repository;

import org.example.booklog.domain.UserBook;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserBookRepository extends JpaRepository<UserBook, Long> {
    List<UserBook> findByUsername(String username);
}
