import 'package:cached_network_image/cached_network_image.dart';

import 'package:dokan/core/constants/app_colors.dart';
import 'package:dokan/core/constants/app_values.dart';
import 'package:dokan/core/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';


class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              FilterWidget(),
              const SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.65, // Adjust aspect ratio as needed
                ),
                //  padding: EdgeInsets.all(8.0), // padding around the grid
                itemCount: 5,
                // total number of items
                itemBuilder: (context, index) {
                  return ProductCard(
                    imageUrl:
                        'https://source.unsplash.com/unpaired-green-leather-shoe-on-top-of-white-box-KStSiM1UvPw/1920x1080',
                    title: 'Loafer Show',
                    price: '150',
                    discountedPrice: '79.00',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.discountedPrice,
  });

  final String imageUrl;
  final String title;
  final String price;
  final String discountedPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 225,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 50.0,
                      color: AppColors.red600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '\$$discountedPrice',
                      style: AppTextStyle.headingXXSmall,
                    )
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < 4 ? Icons.star : Icons.star_border,
                      size: 16.0,
                      color: Colors.orange,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
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
                        filters[filter] = value!;
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
                      child: Text('Cancel',style: AppTextStyle.bodyLarge.copyWith(color: AppColors.gray400),),
                    ),
                  ),
                  const SizedBox(width: 24,),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filters
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 56),
                        backgroundColor:const Color( 0xFF1ABC9C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Apply',style: AppTextStyle.bodyLarge.copyWith(color: AppColors.white),),
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
