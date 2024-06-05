import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'config/routes/app_pages.dart';
import 'config/routes/app_routes.dart';
import 'config/theme/app_theme.dart';
import 'core/helper/storage_helper.dart';
import 'core/resource/dependency_injection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        getPages: AppPages.pages,
        initialRoute:

          Routes.LOGIN
        //Routes.CREATEEVENT
      //  StorageHelper.isLoggedIn() ? Routes.DASHBOARD : Routes.LOGIN,


        // home: const Route.h,
      ),
    );
  }
}
