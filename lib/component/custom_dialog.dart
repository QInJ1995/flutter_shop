import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @descriptions: Dialog封装
/// @author: frqin
/// @date: 2020-08-05
/// version: 1.0.0

class CustomDialog extends Dialog {
  final String title; // 顶部标题
  final String desc; // 内容
  final List buttons; // 自定义按钮
  final Function click; // 点击回掉函数

  CustomDialog({this.title, this.desc, this.buttons, this.click});

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonsList = [];
    if (buttons.length == 1) {
      var buttonName = buttons[0];
      buttonsList = [
        CupertinoDialogAction(
          child: Text('$buttonName'),
          onPressed: () {
            this.click();
            Navigator.pop(context);
          },
        ),
      ];
    } else if (buttons.length == 2) {
      var leftButtonName = buttons[0];
      var rightButtonName = buttons[1];
      buttonsList = [
        CupertinoDialogAction(
          child: Text('$leftButtonName'),
          onPressed: () {
            this.click();
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text('$rightButtonName'),
          onPressed: () {
            this.click();
            Navigator.pop(context);
          },
        ),
      ];
    }

    return CupertinoAlertDialog(
      title: Text('$title'),
      content: Text('$desc'),
      actions: buttonsList,
    );
  }
}
