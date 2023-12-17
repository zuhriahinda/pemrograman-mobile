import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class DatabaseAPI {
  late final Client client;
  late final Account account;
  late final Databases databases;

  DatabaseAPI() {
    client = Client();
    init();
  }

  init() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6560118bba3e9b0f0c8d')
        .setSelfSigned();
    account = Account(client);
    databases = Databases(client);
  }

  Future<Document> updateMessage(
      {required String id, required String updatedMessage}) {
    return databases.updateDocument(
      databaseId: "6565c695453ca5abb004",
      collectionId: "6565c6aa47d52e81e6ed",
      documentId: id,
      data: {
        'text': updatedMessage,
        'date': DateTime.now().toString(),
      },
    );
  }

  Future<Document> getMessageById({required String id}) {
    return databases.getDocument(
      databaseId: "6565c695453ca5abb004",
      collectionId: "6565c6aa47d52e81e6ed",
      documentId: id,
    );
  }

  Future<DocumentList> getMessages() {
    return databases.listDocuments(
      databaseId: "6565c695453ca5abb004",
      collectionId: "6565c6aa47d52e81e6ed",
    );
  }

  Future<Document> addMessage({required String message}) {
    return databases.createDocument(
      databaseId: "6565c695453ca5abb004",
      collectionId: "6565c6aa47d52e81e6ed",
      documentId: ID.unique(),
      data: {
        'text': message,
        'date': DateTime.now().toString(),
      },
    );
  }

  Future<dynamic> deleteMessage({required String id}) {
    return databases.deleteDocument(
      databaseId: "6565c695453ca5abb004",
      collectionId: "6565c6aa47d52e81e6ed",
      documentId: id,
    );
  }
}
