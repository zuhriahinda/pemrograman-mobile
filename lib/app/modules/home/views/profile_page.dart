import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/image_picker_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';

import 'home_view.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profile();
}

class _profile extends State<profile> {
  Uint8List? _image;
  Uint8List? _image1;
  RxString imagePath = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  void selectImage() async {
    final img = await pickImagecontroller(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void selectImage1() async {
    final img = await pickImagecontroller(ImageSource.camera);
    setState(() {
      _image1 = img;
    });
    if (_image1 != null) {
      imagePath.value = _image1.toString();
    }
  }

  void saveProfile() {
    if (_image == null && _image1 == null) {
    } else {
      String name = nameController.text;
      String bio = bioController.text;

      if (name.isEmpty) {
        return;
      }

      saveProfileData(name, bio, _image, _image1);

      nameController.clear();
      bioController.clear();
      setState(() {
        _image = null;
        _image1 = null;
      });

      Get.offAll(HomeView());
    }
  }

  void saveProfileData(
      String name, String bio, Uint8List? image, Uint8List? image1) {
    print("Saving profile data");
    print("Name: $name");
    print("Bio: $bio");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 56, 55, 55),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : _image1 != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image1!),
                        )
                      : CircleAvatar(
                          radius: 64,
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: selectImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 8.0),
                  ),
                  child: const Text(
                    "Select image from gallery",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: selectImage1,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 8.0),
                  ),
                  child: const Text(
                    "Select image from camera",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 60, right: 10, left: 10, bottom: 20),
              child: SizedBox(
                height: 30,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 20),
              child: SizedBox(
                height: 30,
                child: TextField(
                  controller: bioController,
                  decoration: InputDecoration(
                    hintText: "Enter Description",
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 20),
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    elevation: 0,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 8.0),
                  ),
                  child: const Text(
                    "Save Image",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
