import 'package:flutter/material.dart';
// import '../model/details.dart';
// import '../service/service_method.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DetailsInfoProvide with ChangeNotifier {
  Object goodsInfo = null;
  // DetailsModel goodsInfo =null;

  //从后台获取商品信息
  // getGoodsInfo(String id) {
  //   var formData = {
  //     'goodId': id,
  //   };
  //   request('getGoodDetailById', formData: formData).then((val) {
  //     var responseData = json.decode(val.toString());
  //     print(responseData);
  //     goodsInfo = DetailsModel.fromJson(responseData);

  //     notifyListeners();
  //   });
  // }
  getGoodsInfo(String id) {
    rootBundle.loadString('mock/getMallGoods.json').then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      goodsInfo = responseData;
      // goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
