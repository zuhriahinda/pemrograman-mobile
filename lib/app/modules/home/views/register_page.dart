import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/modules/home/controllers/auth_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.blueGrey,
          image: DecorationImage(
            image: AssetImage('images/bg3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Obx(() {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 118, 118, 118), // Ubah warna tombol disini
                  ),
                  onPressed: _authController.isLoading.value
                      ? null
                      : () {
                          _authController.registerUser(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                  child: _authController.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Register'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
