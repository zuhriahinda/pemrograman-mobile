// ... (Previous imports)

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/auth_api.dart';
import 'package:flutter_application_1/app/modules/home/controllers/database_api.dart';
import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final DatabaseAPI database = DatabaseAPI();
  late List<Document>? messages = [];
  TextEditingController messageTextController = TextEditingController();
  TextEditingController updatedTextController = TextEditingController();
  AuthStatus authStatus = AuthStatus.uninitialized;

  @override
  void initState() {
    super.initState();
    final AuthAPI appwrite = context.read<AuthAPI>();
    authStatus = appwrite.status;
    loadMessages();
  }

  loadMessages() async {
    try {
      final value = await database.getMessages();
      setState(() {
        messages = value.documents;
      });
    } catch (e) {
      print(e);
    }
  }

  addMessage() async {
    try {
      await database.addMessage(message: messageTextController.text);
      const snackbar = SnackBar(content: Text('Post added!'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      messageTextController.clear();
      loadMessages();
    } on AppwriteException catch (e) {
      showAlert(title: 'Error', text: e.message.toString());
    }
  }

  deleteMessage(String id) async {
    try {
      await database.deleteMessage(id: id);
      loadMessages();
    } on AppwriteException catch (e) {
      showAlert(title: 'Error', text: e.message.toString());
    }
  }

  updateMessage(String id, String updatedMessage) async {
    try {
      await database.updateMessage(id: id, updatedMessage: updatedMessage);
      const snackbar = SnackBar(content: Text('Post updated!'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      loadMessages();
    } on AppwriteException catch (e) {
      showAlert(title: 'Error', text: e.message.toString());
    }
  }

  showMessageDetails(String id) async {
    try {
      final document = await database.getMessageById(id: id);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Post Details'),
            content: Text(
                'Text: ${document.data['text']}\nDate: ${document.data['date']}'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    } on AppwriteException catch (e) {
      showAlert(title: 'Error', text: e.message.toString());
    }
  }

  editMessageInput(BuildContext context, String id, String initialText) {
    updatedTextController.text = initialText;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Post'),
          content: TextField(
            controller: updatedTextController,
            decoration: InputDecoration(hintText: 'Enter updated text'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                updateMessage(id, updatedTextController.text);
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  showAlert({required String title, required String text}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Recomendation'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeView(),
                ));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/a.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                authStatus == AuthStatus.authenticated
                    ? TextField(
                        controller: messageTextController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                        ),
                      )
                    : const Center(),
                const SizedBox(height: 10),
                authStatus == AuthStatus.authenticated
                    ? ElevatedButton.icon(
                        onPressed: () {
                          addMessage();
                        },
                        icon: const Icon(Icons.send),
                        label: const Text("Send"),
                      )
                    : const Center(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: messages?.length ?? 0,
                    itemBuilder: (context, index) {
                      final message = messages![index];
                      return Card(
                        child: ListTile(
                          title: Text(message.data['text']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  deleteMessage(message.$id);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  showMessageDetails(message.$id);
                                },
                                icon: const Icon(Icons.info),
                              ),
                              IconButton(
                                onPressed: () {
                                  editMessageInput(context, message.$id,
                                      message.data['text']);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
