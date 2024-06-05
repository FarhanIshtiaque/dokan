import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:dokan/feature/product/controller%20/homeController.dart';
import 'package:dokan/feature/product/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:iconly/iconly.dart';

import '../../../core/constants/app_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      body:  PageView(
        controller: homeController.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [ProductList(),Text('data'),Text('data'),Text('data')],
      ),
      bottomNavigationBar:  Obx(
        ()=> CustomNavigationBar(

          iconSize: 30.0,
          isFloating: true,
          selectedColor: AppColors.white,
          strokeColor: AppColors.white,
          unSelectedColor: Colors.white,
          backgroundColor: AppColors.sunsetOrange,
          borderRadius: const Radius.circular(30.0),

          //   blurEffect: true,
          // opacity: 0.8,
          items: [
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.home),
              selectedIcon: const Icon(IconlyBold.home),
              //  title: Text("Home"),
            ),
            CustomNavigationBarItem(
              icon: const HeroIcon(HeroIcons.squares2x2),
              selectedIcon: const HeroIcon(HeroIcons.squares2x2,style: HeroIconStyle.solid),
              //  title: Text("Cart"),
            ),
            CustomNavigationBarItem(
              icon: const HeroIcon(HeroIcons.magnifyingGlass),
              selectedIcon: const HeroIcon(HeroIcons.magnifyingGlass,style: HeroIconStyle.solid),
              // title: Text("Explore"),
            ),
            CustomNavigationBarItem(
              icon: const HeroIcon(HeroIcons.shoppingCart),
              selectedIcon: const HeroIcon(HeroIcons.shoppingCart,style: HeroIconStyle.solid),
              // title: Text("Search"),
            ),
            CustomNavigationBarItem(
              icon: const Icon(IconlyLight.profile),
              selectedIcon: const Icon(IconlyBold.profile),
              //  title: Text("Contact"),
            ),
          ],
           currentIndex: homeController.currentIndex.value,
          onTap: (index) {
           homeController.currentIndex(index) ;

            HapticFeedback.lightImpact();
           homeController.   controller.animateToPage(index,
                duration: const Duration(microseconds: 400),
                curve: Curves.easeInOutCubicEmphasized);
          },
        ),
      ),
    );
  }
}
