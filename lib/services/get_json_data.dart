import 'dart:convert' as convert;
import 'package:aventech_assignment/data/json_data.dart';
import 'package:aventech_assignment/data/product_pojo.dart';
// import 'package:aventech_assignment/data/product_pojo.dart';

class GetJson {
  List<Product> productList = [];

  List<Product> getJsonData() {
    dynamic jsonResponse = convert.jsonDecode(jsonData);
    for (int i = 0; i < jsonResponse.length; i++) {
      String categoryId = jsonResponse[i]['CATEGORY_ID'].toString();
      String categories = jsonResponse[i]['Categories'].toString();
      String itemId = jsonResponse[i]['ITEM_ID'].toString();
      String englishName = jsonResponse[i]['ENGISH_NAME'].toString();
      String price = jsonResponse[i]['PRICE'].toString();
      Product product = new Product(
          categoryId: categoryId,
          categories: categories,
          itemId: itemId,
          englishName: englishName,
          price: price);

      // product.categoryId = categoryId;
      // product.categories = categories;
      // product.itemId = itemId;
      // product.englishName = englishName;
      // product.price = price;

      productList.add(product);
    }
    return productList;
  }
}
