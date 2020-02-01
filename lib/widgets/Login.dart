import 'package:flutter/material.dart';

import 'MainWidget.dart';


// short: stf
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'My eShop',
                    style: TextStyle(fontSize: 50.0)
                  ),
                  Container(width: 10.0,),
                  Icon(Icons.pets),
                ],
              ),

                Container(height: 30.0,),

                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '이메일을 입력하세요'
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '비밀번호를 입력하세요'
                    ),
                  ),
                ),

                Container(height: 10.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text('sign in'),
                      onPressed: () async {
//                        final res = await http.get('http://1.234.4.139:3300/api/items');
//                        print('statusCode: ${res.statusCode}');
//                        print('header: ${res.headers}');
//                        print('body: ${res.body}');
                        await Navigator.pushNamed(context, '/main');
                        //print("테스트");
//                        await Navigator.push(
//                            context,
//                            MaterialPageRoute(builder: (context) => MainWidget(),)
//                        );
                      },
                    ),
                    Container(height: 10,),
                    FlatButton(
                      child: Text('sign up'),
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/sign-up');
                      },
                    ),
                  ],
                ),
             ],
            )
        )
    );
  }
}