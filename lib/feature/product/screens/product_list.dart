import 'package:dokan/core/constants/app_colors.dart';
import 'package:dokan/core/constants/app_values.dart';
import 'package:dokan/core/constants/text_styles.dart';
import 'package:dokan/feature/product/controller%20/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/product_card.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: AppTextStyle.headingSmall,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: HeroIcon(HeroIcons.magnifyingGlass),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppValues.horizontalPadding),
          child: Column(
            children: [
              const FilterWidget(),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.65, // Adjust aspect ratio as needed
                  ),
                  itemCount: productController.productList.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      imageUrl:
                          productController.productList[index].images[0].src,
                      title: productController.productList[index].name,
                      price: productController.productList[index].regularPrice,
                      discountedPrice:
                          productController.productList[index].price,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          builder: (context) => FilterBottomSheet(),
        );
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 21),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HeroIcon(HeroIcons.adjustmentsVertical, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Sort by',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  HeroIcon(HeroIcons.chevronDown, color: Colors.grey),
                  SizedBox(width: 8.0),
                  HeroIcon(HeroIcons.listBullet, color: Colors.grey),
                ],
              ),
            ],
          )),
    );
  }
}
