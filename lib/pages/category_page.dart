import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provide/provide.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List categoryList = [];
  List categoryGoodsList = [];
  var listIndex = 0; //索引

  @override
  void initState() {
    _getCategory();
    _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.0, color: Colors.black12))),
      child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return _leftInkWel(index);
        },
      ),
    );
  }

  Widget _leftInkWel(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        // print('点击了商品分类导航${index}');
        setState(() {
          listIndex = index;
        });
        var childList = categoryList[index].bxMallSubDto;
        var categoryId = categoryList[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _getGoodList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        // padding: EdgeInsets.only(left: 10.0, top: 20.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12),
          ),
        ),
        child: Text(
          categoryList[index].mallCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  //得到后台大类数据
  // void _getCategory() async {
  //   await request('getCategory').then((val) {
  //     var data = json.decode(val.toString());
  //     CategoryModel category = CategoryModel.fromJson(data);
  //     setState(() {
  //       list = category.data;
  //     });
  //      Provide.value<ChildCategory>(context).getChildCategory( list[0].bxMallSubDto);
  //     print(list[0].bxMallSubDto);
  //     list[0].bxMallSubDto.forEach((item) => print(item.mallSubName));
  //   });
  // }

  void _getCategory() async {
    await rootBundle.loadString('mock/getCategory.json').then((val) {
      var data = json.decode(val.toString());
      CategoryModel list = CategoryModel.fromJson(data);
      setState(() {
        categoryList = list.data;
      });
      Provide.value<ChildCategory>(context).getChildCategory(
          categoryList[0].bxMallSubDto, categoryList[0].mallCategoryId);
      // print(categoryList[0].bxMallSubDto);
      // categoryList[0].bxMallSubDto.forEach((item) => print(item.mallSubName));
      // list.data.forEach((item) => print(item.mallCategoryName));
    });
  }

  //得到商品列表数据
  // void _getGoodList({String categoryId}) async {
  //   var data = {
  //     'categoryId': categoryId == null ? '1' : categoryId,
  //     'categorySubId': '',
  //     'page': 1
  //   };
  //   await request('getMallGoods', formData: data).then((val) {
  //     var data = json.decode(val.toString());
  //     CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
  //     Provide.value<CategoryGoodsListProvide>(context)
  //         .getGoodsList(goodsList.data);
  //   });
  // }
  // void _getGoodList(String categorySubId) {
  //   var data = {
  //     'categoryId': Provide.value<ChildCategory>(context).categoryId,
  //     'categorySubId': categorySubId,
  //     'page': 1
  //   };

  //   request('getMallGoods', formData: data).then((val) {
  //     var data = json.decode(val.toString());
  //     CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
  //     // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
  //     Provide.value<CategoryGoodsListProvide>(context)
  //         .getGoodsList(goodsList.data);
  //   });
  // }

  void _getGoodList({String categoryId}) async {
    if (categoryId == '1' || categoryId == null) {
      await rootBundle.loadString('mock/getMallGoods.json').then((val) {
        var data = json.decode(val.toString());
        CategoryGoodsListModel goodsList =
            CategoryGoodsListModel.fromJson(data);
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodsList.data);
      });
    } else {
      // Fluttertoast.showToast(
      //   msg: "This is Center Short Toast",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
    }
  }
}

// 小类右侧导航
class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.black12),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  index, childCategory.childCategoryList[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        // _getGoodList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

//商品列表，可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, value) {
        if (value.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: ListView.builder(
                itemCount: value.goodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(value.goodsList, index);
                },
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 200.0),
            child: Text('暂无数据'),
          );
        }
      },
    );
  }

  // void _getGoodList()async {
  //   var data={
  //     'categoryId':'4',
  //     'categorySubId':"",
  //     'page':1
  //   };
  //   await request('getMallGoods',formData:data ).then((val){
  //       var data = json.decode(val.toString());
  //       print('分类商品列表：>>>>>>>>>>>>>${data}');
  //   });

  // }

  // 商品图片
  Widget _goodsImage(newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  // 商品名称
  Widget _goodsName(newList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  // 商品价格
  Widget _goodsPrice(newList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(children: <Widget>[
        Text(
          '价格:￥${newList[index].presentPrice}',
          style: TextStyle(
            color: Colors.pink,
            fontSize: ScreenUtil().setSp(30),
          ),
        ),
        Text(
          '￥${newList[index].oriPrice}',
          style: TextStyle(
              color: Colors.black26, decoration: TextDecoration.lineThrough),
        ),
      ]),
    );
  }

  // 商品组合
  Widget _listWidget(newList, int index) {
    return InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.black12),
            ),
          ),
          child: Row(
            children: <Widget>[
              _goodsImage(newList, index),
              Column(
                children: <Widget>[
                  _goodsName(newList, index),
                  _goodsPrice(newList, index),
                ],
              ),
            ],
          ),
        ));
  }
}
