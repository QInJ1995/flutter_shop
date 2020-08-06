import 'package:flutter/material.dart';


class CustomerItem extends StatefulWidget {
  // 顾客头像地址
  String pictureURL;
  // 顾客姓名
  String customerName;
  // 顾客电话
  String customerPhone;
  // 上边时间信息
  String topInfo;
  // 下边购物信息
  String bottomInfo;
  // 点击方法
  Function click;
  // 是否显示小红点
  bool isShowRedDot = true;
  CustomerItem(
      {Key key,
      this.pictureURL,
      this.customerName,
      this.customerPhone,
      this.topInfo,
      this.bottomInfo,
      this.click})
      : super(key: key);

  @override
  _CustomerItemState createState() => _CustomerItemState();
}

class _CustomerItemState extends State<CustomerItem> {
  String pictureURL;
  String customerName;
  String customerPhone;
  String topInfo;
  String bottomInfo;
  String firstName;
  Function click;
  bool isShowRedDot;
  @override
  void initState() {
    pictureURL = widget.pictureURL;
    customerName = widget.customerName;
    customerPhone = widget.customerPhone;
    topInfo = widget.topInfo;
    bottomInfo = widget.bottomInfo;
    click = widget.click;
    firstName = widget.customerName.substring(0, 1);
    isShowRedDot = widget.isShowRedDot;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isShowRedDot = false;
          });
          this.click();
        },
        child: Container(
          color: Colors.white,
            child: Row(
          children: <Widget>[
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                // 头像
                pictureURL != '' && pictureURL != null
                    ? Container(
                        // 头像地址不为空
                        width: 50.0,
                        height: 50.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "$pictureURL",
                              ),
                            )),
                      )
                    : Container(
                        // 头像地址为空
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50.0),
                            color: Colors.grey),
                        child: Text(
                          '$firstName',
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                Positioned(
                  // 小红点
                  child: isShowRedDot
                      ? Container(
                          width: 8.0,
                          height: 8.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.red),
                        )
                      : Container(),
                )
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  // 顾客姓名、电话
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
                    ),
                    child: ListTile(
                        title: Text(
                          '$customerName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$customerPhone',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          // 顾客行为信息
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '$topInfo',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                              ),
                              Container(
                                child: Text('$bottomInfo',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0)),
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
