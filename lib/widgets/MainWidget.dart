import 'package:flutter/material.dart';
import 'package:test_app_001/widgets/ItemList.dart';
import 'package:test_app_001/widgets/Profile.dart';
import 'package:test_app_001/utils/Global.dart';

import 'Cart.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: SafeArea(
        child: TabBar(
          controller: _tabController,
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

    return Scaffold(
        appBar: appBar,

        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ItemList(
              onAddToCart: () {
                _tabController.animateTo(1);
              }
            ),
            Cart(),
            Profile()
          ],
        )
    );
  }
}
