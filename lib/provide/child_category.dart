import 'package:flutter/material.dart';
import '../model/category.dart';

//ChangeNotifier的混入是不用管理听众
class ChildCategory with ChangeNotifier {
    List<BxMallSubDto> childCategoryList = []; //商品列表
    int childIndex = 0; //子类索引值
    String categoryId = '1'; //大类ID
    String subId =''; //小类ID 

  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    categoryId=id;
    childIndex = 0;
    subId=''; //点击大类时，把子类ID清空
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    //传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId=id;
    notifyListeners();
  }
}
