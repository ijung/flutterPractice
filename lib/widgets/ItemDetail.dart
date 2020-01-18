import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemDetail extends StatefulWidget {
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  _ItemInfo _itemInfo;


  @override
  Widget build(BuildContext context) {
    _initItemInfo ();

    Container detailContents = Container(
      margin: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _itemInfo.detailContents.map<Widget>((content) {
          return Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(content, style: TextStyle(fontSize: 15.0),),
          );
        }).toList(),
      ),
    );

    Container cart = Container(
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
          )
        ],
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("상품 상세"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // image
              Container(
                margin: EdgeInsets.all(30.0),
                width: double.infinity,
                child: _itemInfo.image,
              ),

              // title
              Text(
                _itemInfo.title,
                style: TextStyle(fontSize: 22.0),
              ),

              SizedBox(height: 10.0,),

              // description
              Text(
                _itemInfo.description,
                style: TextStyle(fontSize: 15.0, color: Colors.black54)
              ),

              SizedBox(height: 10.0,),

              // price
              Text(
                _itemInfo.price,
                style: TextStyle(fontSize: 18.0, color: Colors.orange),
              ),

              SizedBox(height: 10.0,),

              // detail contents
              detailContents,

              // cart
              cart
            ],
          ),
        )
    );
  }

  void _initItemInfo () {
    if (_itemInfo != null)
      return;

    _itemInfo = _ItemInfo(
      Image.network('http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'),
      '뼈다귀 모양 베개',
      '우리 귀여운 강아지에게 꿀잠을!!',
      '10,000원',
      <String>[
        '아이에게 꿀잠을 선사할 수 있는 베개입니다.',
        '뼈다귀 모양이므로 강아지에게 뼈다귀를 뜯는 꿈을 꿀 수 있도록 합니다.',
        '가나다라 마바사 아자차카 타파하',
        '',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
        '테스트 라인 입니다',
      ],
    );
  }
}

class _ItemInfo {
  Image image;
  String title;
  String description;
  String price;
  List<String> detailContents;

  _ItemInfo(
      this.image, this.title, this.description, this.price, this.detailContents
      );
}