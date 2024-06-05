import 'package:dokan/config/routes/app_pages.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../feature/auth/screens/login.dart';
import '../../feature/auth/screens/sign_up.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => const Login()),
    GetPage(name: Routes.SIGNUP, page: () => const SignUp()),
  ];

}
