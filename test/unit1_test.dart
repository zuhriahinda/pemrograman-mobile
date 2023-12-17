import 'package:flutter_application_1/API.dart';
import 'package:test/test.dart';
import 'dart:convert';

void main() {
  group('ArticlesResult Test', () {
    test('ArticlesResult fromJson', () {
      // Sample JSON data
      final jsonString = '''
        {
          "page": 1,
          "per_page": 10,
          "total": 100,
          "total_pages": 10,
          "data": [
            {
              "id": 1,
              "email": "john.doe@example.com",
              "first_name": "John",
              "last_name": "Doe",
              "avatar": "https://example.com/avatar.jpg"
            }
          ],
          "support": {
            "url": "https://example.com",
            "text": "Support text"
          }
        }
      ''';

      // Convert JSON to ArticlesResult object
      final articlesResult = articlesResultFromJson(jsonString);

      // Verify the correctness of the parsed data
      expect(articlesResult.page, 1);
      expect(articlesResult.perPage, 10);
      expect(articlesResult.total, 100);
      expect(articlesResult.totalPages, 10);

      expect(articlesResult.data.length, 1);
      final datum = articlesResult.data[0];
      expect(datum.id, 1);
      expect(datum.email, 'john.doe@example.com');
      expect(datum.firstName, 'John');
      expect(datum.lastName, 'Doe');
      expect(datum.avatar, 'https://example.com/avatar.jpg');

      expect(articlesResult.support.url, 'https://example.com');
      expect(articlesResult.support.text, 'Support text');
    });

    test('ArticlesResult toJson', () {
      // Sample ArticlesResult object
      final articlesResult = ArticlesResult(
        page: 1,
        perPage: 10,
        total: 100,
        totalPages: 10,
        data: [
          Datum(
            id: 1,
            email: 'john.doe@example.com',
            firstName: 'John',
            lastName: 'Doe',
            avatar: 'https://example.com/avatar.jpg',
          ),
        ],
        support: Support(
          url: 'https://example.com',
          text: 'Support text',
        ),
      );

      // Convert ArticlesResult object to JSON
      final jsonString = articlesResultToJson(articlesResult);

      // Verify the correctness of the generated JSON
      final expectedJson = jsonEncode({
        "page": 1,
        "per_page": 10,
        "total": 100,
        "total_pages": 10,
        "data": [
          {
            "id": 1,
            "email": "john.doe@example.com",
            "first_name": "John",
            "last_name": "Doe",
            "avatar": "https://example.com/avatar.jpg"
          }
        ],
        "support": {"url": "https://example.com", "text": "Support text"}
      });
      expect(jsonString, expectedJson);
    });
  });
}
