import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app_001/utils/StringUtil.dart';

import 'ItemDetail.dart';


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<_ItemInfo> _itemInfos;
  final _itemIdControllerMap = Map<int, TextEditingController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    for(final ctr in _itemIdControllerMap.values)
      ctr.dispose();
    _itemIdControllerMap.clear();
  }

  @override
  Widget build(BuildContext context) {

    _initItemInfos();

    //_itemInfos.map<Widget>((ii) {});
    // make widgets
    final widgets = <Widget>[];
    for (final ii in _itemInfos) {
      widgets.add(
          Row(
            children: <Widget>[
              Checkbox(
                value: ii.isChecked,
                onChanged: (v)=>setState(()=>ii.isChecked=v),
              ),
              Expanded(
                flex: 3,
                child: FlatButton(
                  child: Container(
                    height: 150.0,
                    margin: EdgeInsets.only(right: 20.0),
                    child: ii.image,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> ItemDetail()),
                    );
                  },
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ii.title,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      '${StringUtil.makeCommaedString(ii.price)}원',
                      style: TextStyle(fontSize: 15.0, color: Colors.orange),
                    ),
                    Row(
                      children: <Widget>[
                        Text('개수'),
                        Expanded(child: SizedBox()),
                        Container(
                          width : 20,
                          height: 20,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.add, size: 20),
                            onPressed: () {
                                _itemIdControllerMap[ii.id].text = (min(ii.count + 1, 999)).toString();
                                },
                          ),
                        ),
                        SizedBox(
                          width: 40.0,
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(),
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(1),
                              isDense: true
                            ),
                            controller: _itemIdControllerMap[ii.id],
                          ),
                        ),
                        Container(
                          width : 20,
                          height: 20,
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.remove, size: 20),
                            onPressed: () {
                              _itemIdControllerMap[ii.id].text = (max(ii.count - 1, 0)).toString();
                            },
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Text('금액'),
                        Expanded(child: SizedBox()),
                        Text('${StringUtil.makeCommaedString(ii.price*ii.count)}원', style: TextStyle(fontSize: 18, color: Colors.green),),
                        SizedBox(width: 15),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          )
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: widgets,
            ),
          ),

          Container(
            height: 10,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black54),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('총 가격:', style: TextStyle(fontSize: 18),),
                SizedBox(width: 18),
                Text(
                  '${StringUtil.makeCommaedString(_itemInfos.where((ii)=>ii.isChecked).map((ii)=>ii.price*ii.count).fold(0, (a, b)=>a+b))} 원',
                  style: TextStyle(fontSize: 20, color: Colors.orange),
                ),
              ],
            ),
          ),

          SizedBox(height: 5),

          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('구매하기', style: TextStyle(fontSize: 16)),
              onPressed: () {

              },
            ),
          ),

          SizedBox(height: 10,),

        ],
      ),
    );
  }

  void _initItemInfos () {
    if (_itemInfos != null)
      return;

    _itemInfos = <_ItemInfo>[
      _ItemInfo(0, Image.network('http://thumbnail.10x10.co.kr/webimage/image/basic600/137/B001377515.jpg'    ), '뼈다귀 모양 베개'  , 10000, 1),
      _ItemInfo(1, Image.network('https://mi6.rightinthebox.com/images/384x384/201704/pqf1493005948537.jpg'   ), '빨간 스웨터'       ,  8000, 2),
      _ItemInfo(2, Image.network('https://seoul-p-studio.bunjang.net/product/81561624_3_1520763876_w640.jpg'  ), '강아지 용 백팩'    , 18000, 3),
      _ItemInfo(3, Image.network('https://mi7.rightinthebox.com/images/384x384/201307/khabye1372647520194.jpg'), '귀여운 강아지 신발', 12000, 1),
    ];

    for(final ii in _itemInfos)
      {
        final ctr = TextEditingController(text: '${ii.count}');
        _itemIdControllerMap[ii.id] = ctr;
        ctr.addListener(() {
          setState(() {
            ii.count = (ctr.text == '') ? 0 : int.parse(ctr.text);
          });
        });
      }
  }
}


class _ItemInfo {
  int    id;
  Image  image;
  String title;
  int    price;
  int    count;
  bool   isChecked = true;

  _ItemInfo(this.id, this.image, this.title, this.price, this.count);
}