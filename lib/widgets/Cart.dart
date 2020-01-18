import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Item 데이터 형식
class _ItemInfo {
  int    id;
  Image  image;
  String title;
  int    price;
  int    count;
  bool   isChecked = true;

  _ItemInfo(this.id, this.image, this.title, this.price, this.count);
}


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<_ItemInfo> _itemInfos;

  @override
  Widget build(BuildContext context) {
    _initItemInfos();
    final itemWidgets = <Widget>[];
    for (final ii in _itemInfos) {
      var isCheaked = true;

      var title = Text(ii.title, style: TextStyle(fontSize: 18.0),);
      var itemCheckBox = Checkbox(
        value: isCheaked, // isChecked는 예시용 bool 변수
        onChanged: (v) => setState(() => isCheaked = v),
      );
      var itemImage = Container(
        height: 120.0,
        margin: EdgeInsets.only(right: 20.0),
        child: ii.image,
      );
      var itemPrice = Text(ii.price.toString(),
        style: TextStyle(fontSize: 15.0, color: Colors.orange),);
      var itemCount = Row(
        children: <Widget>[
          Expanded(child: Text("개수")),

          Expanded(
            child: Row(
              children: <Widget>[
                Icon(Icons.add, size: 20),
                SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: TextField(
                    controller: TextEditingController(text: ii.count
                        .toString()),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(2),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Icon(Icons.remove, size: 20),
              ],
            ),
          ),
        ],
      );
      var itemPriceSum = Row(
        children: <Widget>[
          Expanded(child: Text("금액", textAlign: TextAlign.left,)),
          Expanded(child: Text(
            ii.price.toString() + "원", textAlign: TextAlign.right,
            style: TextStyle(color: Colors.green),))
        ],
      );
      var itemSummary = Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            itemPrice,
            itemCount,
            itemPriceSum
          ],
        ),
      );
      
      itemWidgets.add(
        //Text('테스트 $i', style: TextStyle(fontSize: 90.0),)
        Row(
          children: <Widget>[
            itemCheckBox,
            itemImage,
            itemSummary
          ],
        ),
      );
      itemWidgets.add(SizedBox(height: 20.0,));
    }


    var cart = Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60.0,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(9),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.numberWithOptions(),
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            ),
          ),

          // 수량
          Text('개', style: TextStyle(fontSize: 16.0),),

          Expanded(
            child: SizedBox(),
          ),

          // price
          Text("92, 000 원",
            style: TextStyle(fontSize: 18, color: Colors.orange),)
        ],
      ),
    );

    var addToCartButton = Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 5, 30, 8),
      child: FlatButton(
        color: Colors.blue,
        textColor: Colors.white,
        child: Text('장바구니에 넣기', style: TextStyle(fontSize: 16.0),),
        onPressed: () {

        },
        padding: EdgeInsets.only(top: 10, bottom: 10),
      ),
    );

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
              children: itemWidgets
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              height: 10.0,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black54),
                  )
              ),
            ),
            cart,
            addToCartButton
          ],
        )
      ],
    );
  }

  void _initItemInfos() {
    if (_itemInfos != null)
      return;

    _itemInfos = <_ItemInfo>[
      _ItemInfo(0, Image.network(
          'http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'),
          '뼈다귀 모양 베개', 10000, 1),
      _ItemInfo(1, Image.network(
          'https://mi6.rightinthebox.com/images/384x384/201704/pqf1493005948537.jpg'),
          '빨간 스웨터', 8000, 2),
      _ItemInfo(2, Image.network(
          'https://seoul-p-studio.bunjang.net/product/81561624_3_1520763876_w640.jpg'),
          '강아지 용 백팩', 18000, 3),
      _ItemInfo(3, Image.network(
          'https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'),
          '귀여운 강아지 신발', 12000, 1),
    ];
  }
}