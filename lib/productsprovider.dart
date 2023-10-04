import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'Products.dart';
import 'RespMain.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier{
  List<Products>listproducts=[];


  Future<List<Products>> fetchproducts()  async {
    final response = await http.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      var getproductsData = json.decode(response.body.toString());
      var res=RespMain.fromJson(getproductsData);
      listproducts =res.products ;
      notifyListeners();
      return listproducts;
    } else {
      throw Exception('Failed to load products');
    }
  }
}