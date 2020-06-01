import 'package:flutter/material.dart';
import 'package:flutter_shop/routers/routes.dart';
// 引入全局状态管理
import 'package:provide/provide.dart';
// 引入路由
import 'package:fluro/fluro.dart';

import './pages/index_page.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
// 引入路由配置文件
import './routers/application.dart';
import './routers/routes.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //创建一个Router对象
    final router = Router();
    //配置Routes注册管理
    Routes.configureRoutes(router);
    //将生成的router给全局化
    Application.router = router;
    return Container(
      child: Container(
        child: MaterialApp(
          title: '黑猫商城+',
          // 路由
          onGenerateRoute: Application.router.generator,
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
