import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app_001/utils/Global.dart';
import 'package:test_app_001/utils/ServerApi.dart';
import 'package:test_app_001/widgets/LoadingWrapper.dart';
import 'package:http/http.dart' as http;

import 'HttpTest.dart';
import 'MainWidget.dart';


// short: stf
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: LoadingWrapper(
              isLoading: _isLoading,
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
                      controller: _emailCtrl,
                      decoration: InputDecoration(
                        hintText: '이메일을 입력하세요'
                      ),
                    ),
                  ),

                  // password
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: TextField(
                      controller: _passwordCtrl,
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
                          try {
                            setState(() {
                              _isLoading = true;
                            });

                            final res = await ServerApi.login(_emailCtrl.text, _passwordCtrl.text);
                            Global.token = res.token;
                            Global.id = res.id;
                            setState(() {
                              _isLoading = false;
                            });
                            await Navigator.pushNamed((context), '/main');

                          } on ServerApiException catch(e) {
                            print('로그인 실패: ${json.decode(e.response.body)['message']}');
                            setState(() {
                              _isLoading = false;
                            });
                          }

                          catch(e) {
                            print('에러: ${e.toString()}');
                            setState(() {
                              _isLoading = false;
                            });
                          }


//                          await Navigator.pushNamed(context, '/main');
//                        await Navigator.push(context, MaterialPageRoute(
//                          builder: (context) => HttpTest(),
//                        )
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
              ),
            )
        )
    );
  }
}