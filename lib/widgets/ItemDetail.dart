import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ItemDetailResult {
  BACK,
  ADD_TO_CART
}

class ItemDetail extends StatefulWidget {
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  _ItemInfo _itemInfo;
  final _countController = TextEditingController(text: '1');
  int _totalPrice;
  bool _isAddCArtButtonDisable = false;

  @override
  void initState() {
    // TODO: implement initState
    _countController.addListener(() {
      print(_countController.text);
      var itemCount = getItemCount(_countController.text);

      setState(() {
        _totalPrice = itemCount * _itemInfo.price;
        _isAddCArtButtonDisable = itemCount == 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _countController.dispose();
  }

  int getItemCount(String cnt)
  {
    if(cnt == null || cnt.isEmpty) return 0;
    return int.parse(_countController.text);
  }


  @override
  Widget build(BuildContext context) {
    _initItemInfo();
    _totalPrice = getItemCount(_countController.text) * _itemInfo.price;

    var image = Container(
      margin: EdgeInsets.all(30.0),
      width: double.infinity,
      child: _itemInfo.image,
    );

    var title = Text(
      _itemInfo.title,
      style: TextStyle(fontSize: 22.0),
    );

    var description = Text(
        _itemInfo.description,
        style: TextStyle(fontSize: 15.0, color: Colors.black54)
    );

    var price = Text(
      '$_totalPrice 원',
      style: TextStyle(fontSize: 18.0, color: Colors.orange),
    );

    var detailContents = Container(
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
              controller: _countController,
            ),
          ),

          // 수량
          Text('개', style: TextStyle(fontSize: 16.0),),

          Expanded(
            child: SizedBox(),
          ),

          // price
          Text('$_totalPrice 원',
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
        onPressed: _isAddCArtButtonDisable ? null : () {
          Navigator.pop(context, ItemDetailResult.ADD_TO_CART);

        },

        padding: EdgeInsets.only(top: 10, bottom: 10),
      ),
    );


    return Scaffold(
        appBar: AppBar(
          title: Text("상품 상세"),
        ),
        body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      image,
                      title,
                      SizedBox(height: 10.0,),
                      description,
                      SizedBox(height: 10.0,),
                      price,
                      SizedBox(height: 10.0,),
                      detailContents,
                    ],
                  ),
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
                  addToCartButton,
                ],
              )
            ]
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
      10000,
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
  int price;
  List<String> detailContents;

  _ItemInfo(
      this.image, this.title, this.description, this.price, this.detailContents
      );
}