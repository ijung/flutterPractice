import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app_001/utils/ServerApi.dart';
import 'package:test_app_001/widgets/ItemDetail.dart';
import 'package:test_app_001/widgets/LoadingWrapper.dart';

class ItemList extends StatefulWidget {


  @override
  _ItemListState createState() => _ItemListState();

  Function onAddToCart;

  ItemList({Key key, @required this.onAddToCart}):super(key: key);
}

class _ItemListState extends State<ItemList> {
  List<_ItemInfo> _itemInfos = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _refreshData();
  }


  @override
  Widget build(BuildContext context) {
    //_initItemInfos();
    final itemWidgets = <Widget>[];
    for (final ii in _itemInfos) {
      itemWidgets.add(
        //Text('테스트 $i', style: TextStyle(fontSize: 90.0),)
        FlatButton(
          onPressed: () async {
            final result = await Navigator.push<ItemDetailResult>(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetail(id: ii.id),
              ),);

            if(result == ItemDetailResult.ADD_TO_CART){
              widget.onAddToCart();
            }
          },
          child: Row(
            children: <Widget>[
              // image
              Container(
                height: 150.0,
                margin: EdgeInsets.only(right:20.0),
                child: ii.image,
              ),

              // text
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // title
                    Text(ii.title, style: TextStyle(fontSize: 18.0),),

                    // description
                    Text(ii.description, style: TextStyle(fontSize: 15.0, color: Colors.black54),),

                    // price
                    Text(ii.price, style: TextStyle(fontSize: 15.0, color: Colors.orange),)
                  ],
                ),
              )
            ],
          ),
        )
      );
    }

    return
      LoadingWrapper(
        isLoading: _isLoading,
        child: ListView(
          children: itemWidgets,
        ),
      );
  }

  void _refreshData() async {
    // loading 띄우기
    setState(() {
      _isLoading = true;
    });

    // 데이터 받아오기
    final items = await ServerApi.fetchItems({});

    setState(() {
      // iteminfos 구성하기
      _itemInfos.clear();
      for (final it in items) {
        print("ID!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        print(it.id.toString());
        _itemInfos.add(
            _ItemInfo(it.id, Image.network(it.image), it.title, it.description, "${it.price} 원")
        );
      }

      // loading 끄기
      _isLoading = false;
    });

    // 화면 갱신
  }
}


class _ItemInfo {
  int id;
  Image image;
  String title;
  String description;
  String price;

  _ItemInfo (this.id, this.image, this.title, this.description, this.price);
  /*
  _ItemInfo (this.image, this.title, this.description, this.price);의 의미
  _ItemInfo (Image image, String title, String description, String price)
  {
    this.image = image;
    this.title = title;
    this.description = description;
    this.price = price;
  }
   */
}