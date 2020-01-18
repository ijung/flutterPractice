import 'package:flutter/material.dart';
import 'package:test_app_001/utils/Global.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: mq.size.height - Global.statusBarHeight - Global.appBarHeight,
            minWidth: mq.size.width,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image(
                      image: NetworkImage(
                          'https://t1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/18hL/image/lsvQGC23i37Cb4FPAvhc0Uc1KEU.jpg'
                      ),
                    ),
                  ),
                ),

                // Name
                Text(
                  '쇼핑왕 꼬부기',
                  style: TextStyle(fontSize: 20.0),
                ),

                // Rank
                Text(
                    'VIP customer',
                    style: TextStyle(color: Colors.blue)
                ),

                SizedBox(
                  height: 30,
                ),

                FractionallySizedBox(
                  widthFactor: 0.62,
                  child:
                  Column(
                    children: <Widget>[
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(margin: EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.phone, color: Colors.black54)),
                        //SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Please enter a phone number',
                            ),
                          ),
                        )
                      ]
                    ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(margin: EdgeInsets.only(right: 20.0),
                                child: Icon(Icons.email, color: Colors.black54)),
                            //SizedBox(width: 10,),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Please enter an e-mail',
                                ),
                              ),
                            )
                          ]
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(margin: EdgeInsets.only(right: 20.0),
                                child: Icon(Icons.flag, color: Colors.black54)),
                            //SizedBox(width: 10,),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Please enter an address',
                                ),
                              ),
                            )
                          ]
                      ),
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
