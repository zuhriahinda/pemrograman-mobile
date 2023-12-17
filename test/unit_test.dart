import 'package:flutter_application_1/app/modules/home/controllers/fetchPosts.dart';
import 'package:http/http.dart' as http;

import 'package:test/test.dart';

void main() {
  group('fetchPosts', () {
    test('returns a Post if the http call completes successfully', () async {
      http.Client client = http.Client();

      try {
        const validURL = 'https://jsonplaceholder.typicode.com/posts/1';
        Posts result = await fetchPosts(client, validURL);

        expect(result.userId, isNotNull);
        expect(result.id, isNotNull);
        expect(result.title, isNotNull);
        expect(result.body, isNotNull);
      } catch (e) {
        fail('Test failed with exception: $e');
      } finally {
        client.close();
      }
    });

    test('throws an exception if the http call completes with an error',
        () async {
      http.Client client = http.Client();

      const invalidURL = 'https://jsonplaceholder.typicode.com/posts/invalid';

      try {
        await fetchPosts(client, invalidURL);
        fail('Test should throw an exception but it did not.');
      } catch (e) {
        expect(e, isException);
      } finally {
        client.close();
      }
    });
  });
}
