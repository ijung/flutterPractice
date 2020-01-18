import 'package:flutter/material.dart';
import 'package:test_app_001/widgets/ItemList.dart';
import 'package:test_app_001/widgets/Profile.dart';
import 'package:test_app_001/utils/Global.dart';

import 'Cart.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.shopping_basket),
              text: 'Item List',
            ),
            Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Cart'
            ),
            Tab(
                icon: Icon(Icons.person),
                text: 'Profile'
            )
          ],
        ),
      ),
    );

    final mq = MediaQuery.of(context);
    Global.statusBarHeight = mq.padding.top; // status bar height
    Global.appBarHeight = appBar.preferredSize.height; // app ber

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: appBar,

          body: TabBarView(
            children: <Widget>[
              ItemList(),
              Cart(),
              Profile()
            ],
          )
      ),
    );
  }
}
