import 'package:dokan/config/routes/app_pages.dart';
import 'package:dokan/feature/product/screens/home.dart';
import 'package:dokan/feature/product/screens/product_list.dart';
import 'package:dokan/feature/profile/screens/update_profile.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../feature/auth/screens/login.dart';
import '../../feature/auth/screens/sign_up.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.LOGIN, page: () => const Login()),
    GetPage(name: Routes.SIGNUP, page: () => const SignUp()),
    GetPage(name: Routes.PRODUCTLIST, page: () => const ProductList()),
    GetPage(name: Routes.HOME, page: () => const Home()),
    GetPage(name: Routes.UPDATEPROFILE, page: () => const UpdateProfile()),
  ];

}
