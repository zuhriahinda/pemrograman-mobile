import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/auth_controller.dart';
import 'package:flutter_application_1/app/modules/home/views/notification_hendler.dart';
import 'package:flutter_application_1/app/modules/home/views/todos_page.dart';
import 'package:flutter_application_1/app/modules/home/views/profile_page.dart';
import 'package:flutter_application_1/app/modules/home/views/webview_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    LocalNotification.initialize();
    // For Forground State
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotification.showNotification(message);
    });
    return Scaffold(
      //app navigasi
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            _authController.logout();
          },
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile(),
                      ));
                },
                color: Colors.white,
                icon: const Icon(Icons.person),
              ))
        ],
      ),

      //bottom navigasi
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web_asset),
            label: '',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TodosPage()));
          } else if (index == 1) {
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WebviewPage()));
          }
        },
      ),

      //TITTLE
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Find the best coffee for you",
              style: GoogleFonts.montserrat(fontSize: 40),
            ),
          ),

          //serch bar
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'find your favorite coffee. . .☕️',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),

          //coffee tile
          Expanded(
              child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CoffeeFile(
                coffeeImage: 'images/latte.jpg',
                coffeeName: 'cappucino',
                coffeeDesk: 'with chocolate',
                coffeePrice: 'Rp.50.000',
              ),
              CoffeeFile(
                coffeeImage: 'images/matcha.jpg',
                coffeeName: 'Matcha Latte',
                coffeeDesk: 'with foam',
                coffeePrice: 'Rp.60.000',
              ),
              CoffeeFile(
                coffeeImage: 'images/americano.jpg',
                coffeeName: 'americano',
                coffeeDesk: 'less sugar',
                coffeePrice: 'Rp.40.000',
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class CoffeeFile extends StatelessWidget {
  final String coffeeImage;
  final String coffeeName;
  final String coffeePrice;
  final String coffeeDesk;

  CoffeeFile({
    required this.coffeeImage,
    required this.coffeeName,
    required this.coffeePrice,
    required this.coffeeDesk,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      //box
      padding: const EdgeInsets.only(left: 25.0, bottom: 55),
      child: Container(
          padding: EdgeInsets.all(20),
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.black,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //coffee image
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(coffeeImage)),

              //coffee name
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffeeName,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),

                    //coffee deskripsi
                    Text(
                      coffeeDesk,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),

              //price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('' + coffeePrice),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 127, 7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.add)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
