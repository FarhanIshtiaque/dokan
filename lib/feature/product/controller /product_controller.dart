import 'dart:convert';
import 'dart:math';

import 'package:dokan/core/constants/app_assets.dart';
import 'package:dokan/core/helper/logger.dart';
import 'package:dokan/feature/product/data/local_data_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var productList = <ProductDataModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    loadJsonAsset();
  }


  Future<void> loadJsonAsset() async {
    final String jsonString = await rootBundle.loadString(AppAssets.localJson);
    final List<dynamic> jsonList= jsonDecode(jsonString);
    productList.addAll(jsonList.map((json) {
      return ProductDataModel.fromJson(json);
    }).toList());
    logger.d(productList[0].name);


  }

  List<ProductDataModel> sortProductsByPriceLowToHigh(List<ProductDataModel> products) {
    products.sort((a, b) {
      double priceA = double.tryParse(a.price) ?? double.infinity;
      double priceB = double.tryParse(b.price) ?? double.infinity;
      return priceA.compareTo(priceB);
    });
    return products;
  }


  List<ProductDataModel> sortProductsByPriceHighToLow(List<ProductDataModel> products) {
    products.sort((a, b) {
      double priceA = double.tryParse(a.price) ?? double.infinity;
      double priceB = double.tryParse(b.price) ?? double.infinity;
      return priceB.compareTo(priceA);
    });
    return products;
  }


  List<ProductDataModel> sortProductsByDateNewestToOldest(List<ProductDataModel> products) {
    products.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    return products;
  }
  List<ProductDataModel> sortProductsByDateOldestToNewest(List<ProductDataModel> products) {
    products.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    return products;
  }

  List<ProductDataModel> sortProductsByBestSelling(List<ProductDataModel> products) {
    products.sort((a, b) => b.totalSales.compareTo(a.totalSales));
    return products;
  }
}