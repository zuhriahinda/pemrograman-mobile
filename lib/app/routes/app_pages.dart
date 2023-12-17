import 'package:flutter_application_1/app/modules/home/views/home_view.dart';
import 'package:flutter_application_1/app/modules/home/views/intro_page.dart';
import 'package:flutter_application_1/app/modules/home/views/login_page1.dart';
import 'package:flutter_application_1/app/modules/home/views/messages_page.dart';
import 'package:flutter_application_1/app/modules/home/views/register_page1.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
