import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @descriptions: 卡片封装
/// @author: frqin
/// @date: 2020-08-05
/// version: 1.0.0

class CustomCard extends StatefulWidget {
  String title;
  String content;
  bool isRow;
  dynamic height;
  Function click;
  CustomCard({Key key, this.title, this.content, this.isRow, this.height, this.click}) : super(key: key);
  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String title;
  String content;
  bool isRow;
  dynamic height;
  String topTitle;
  String bottomTitle;
  Function click;
  @override
  void initState() {
    title = widget.title;
    content = widget.content;
    isRow = widget.isRow;
    height = widget.height;
    topTitle = widget.title.substring(0,2);
    bottomTitle = widget.title.substring(2,widget.title.length);
    click = widget.click;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.click();
      },
      child: Card(
        //设置圆角度，也可以不设置有默认值
        shape: RoundedRectangleBorder(
          //形状
          //修改圆角
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        //阴影颜色
        color: Colors.white,
        //阴影高度
        elevation: 4.0,
        child: Container(
          height: height,
          child: isRow ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("$topTitle", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    Text("$bottomTitle", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Text("$content", style: TextStyle(color: Colors.grey)),
              )
            ],
          ) : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.0),
                child: Text("$title", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10.0),
                margin: EdgeInsets.only(top: 20.0),
                child: Text("$content", style: TextStyle(color: Colors.grey, fontSize: 24.0),)
              )
            ],
          ),
        )
      ),
    );
  }
}

