import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import './pages/index_page.dart';
import './provide/counter.dart';
import './provide/child_category.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(child: MyApp(), providers: providers));
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
              primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    );
  }
}
