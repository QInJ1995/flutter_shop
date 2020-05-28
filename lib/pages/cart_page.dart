import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/counter.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Num(),
            Button()
          ],
        ),
      ),
    );
  }
}

class Num extends StatelessWidget {
  const Num({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 200.0),
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text('${counter.value}', style: TextStyle(fontSize: 20.0),);
        },
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Counter>(context).increament();
        },
        child: Text('增加'),
      ),
    );
  }
}
