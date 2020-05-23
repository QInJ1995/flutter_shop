import 'package:flutter/material.dart';

import './pages/index_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: MaterialApp(
          title: '百姓生活+',
          // debuge图标显示
          debugShowCheckedModeBanner: false,
          // 主题
          theme: ThemeData(
            // App默认颜色
            primaryColor: Colors.pink
          ),
          home: IndexPage(),
        ),
      ),
    );
  }
}