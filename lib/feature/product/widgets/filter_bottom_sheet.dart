import 'package:dokan/feature/product/controller%20/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/text_styles.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Map<String, bool> filters = {
    'Newest': false,
    'Oldest': false,
    'Price low > high': false,
    'Price high > low': false,
    'Best selling': false,
  };

  String _getSelectedFilter() {
    return filters.entries.firstWhere((entry) => entry.value).key;
  }

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                color: const Color(0xFFFFD3DD),
                height: 3,
                width: 47,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Filter',
                style: AppTextStyle.headingXXSmall,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ...filters.keys.map((filter) {
              return ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                horizontalTitleGap: 0,
                title: Text(
                  filter,
                  style: AppTextStyle.labelMedium,
                ),
                leading: Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((states) {
                      if (!states.contains(MaterialState.selected)) {
                        return Colors.transparent;
                      }
                      return AppColors.ultraRed;
                    }),
                    side: const BorderSide(
                        color: AppColors.ultraRed, width: 1.25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    value: filters[filter],
                    onChanged: (bool? value) {
                      setState(() {
                        filters.updateAll(
                                (key, val) => key == filter ? value! : false);
                      });
                    },
                  ),
                ),
              );
            }),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 56),
                        foregroundColor: Colors.grey,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyle.bodyLarge
                            .copyWith(color: AppColors.gray400),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filters
                        String selectedFilter = _getSelectedFilter();
                        Navigator.pop(context);
                      //  logger.d(selectedFilter);
                        if (selectedFilter == 'Oldest') {
                          productController.sortProductsByDateOldestToNewest(
                              productController.productList);
                        } else if (selectedFilter == 'Newest') {
                          productController.sortProductsByDateNewestToOldest(
                              productController.productList);
                        } else if (selectedFilter == 'Price low > high') {
                          productController.sortProductsByPriceLowToHigh(
                              productController.productList);
                        } else if (selectedFilter == 'Price high > low') {
                          productController.sortProductsByPriceHighToLow(
                              productController.productList);
                        } else {
                          productController.sortProductsByBestSelling(
                              productController.productList);
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: AppColors.sunsetOrange,
                              content:
                              Text('Selected Filter: $selectedFilter')),
                        );
                        HapticFeedback.mediumImpact();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 56),
                        backgroundColor: const Color(0xFF1ABC9C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Apply',
                        style: AppTextStyle.bodyLarge
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            )
          ],
        ),
      ),
    );
  }
}