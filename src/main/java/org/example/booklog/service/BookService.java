package org.example.booklog.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import lombok.RequiredArgsConstructor;
import org.example.booklog.domain.Book;
import org.example.booklog.repository.BookRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BookService {

    @Value("${aladin.api-key}")
    private String apiKey;

    @Value("${aladin.api-url}")
    private String apiUrl;

    private final RestTemplate restTemplate = new RestTemplate();
    private final BookRepository bookRepository;

    public List<Book> searchBooks(String query) {
        String url = UriComponentsBuilder.fromHttpUrl(apiUrl)
                .queryParam("ttbkey", apiKey)
                .queryParam("Query", query)
                .queryParam("QueryType", "Title")
                .queryParam("MaxResults", "10")
                .queryParam("start", "1")
                .queryParam("SearchTarget", "Book")
                .queryParam("output", "xml")
                .queryParam("Version", "20131101")
                .build().toUriString();

        String xmlResult = restTemplate.getForObject(url, String.class);

        try {
            XmlMapper xmlMapper = new XmlMapper();
            JsonNode itemsNode = xmlMapper.readTree(xmlResult).path("item");
            List<Book> books = new ArrayList<>();

            for (JsonNode node : itemsNode) {
                Book book = new Book(
                        node.path("isbn").asText(),
                        node.path("title").asText(),
                        node.path("author").asText(),
                        node.path("publisher").asText(),
                        node.path("link").asText(),
                        node.path("cover").asText(),
                        node.path("description").asText()
                );
                bookRepository.save(book);
                books.add(book);
            }
            return books;
        } catch (Exception e) {
            throw new RuntimeException("XML 파싱 중 오류 발생", e);
        }
    }
}
