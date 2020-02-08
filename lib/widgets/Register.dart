import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app_001/utils/Global.dart';
import 'package:test_app_001/widgets/LoadingWrapper.dart';
import 'package:http/http.dart' as http;


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();
  final _nameCtr = TextEditingController();
  final _addressCtr = TextEditingController();

  var _isSubmittable = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailCtr.dispose();
    _passCtr.dispose();
    _nameCtr.dispose();
    _addressCtr.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(title: Text("회원 가입")),
        body: LoadingWrapper(
          isLoading: !_isSubmittable,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  _buildFieldWidget("이메일", _emailCtr, (v) {
                    if(v.trim() == '') return '값을 입력해 주세요';
                    if(v.indexOf('@') == -1) return '이메일 형식이 아닙니다.';
                    return null;}),
                  _buildFieldWidget("비밀번호", _passCtr, (v) {if(v.trim() == '') return '값을 입력해 주세요'; return null;}, isObscureText: true),
                  _buildFieldWidget("이름", _nameCtr, (v) {if(v.trim() == '') return '값을 입력해 주세요'; return null;}),
                  _buildFieldWidget("주소", _addressCtr, (v) {if(v.trim() == '') return '값을 입력해 주세요'; return null;}),

                  SizedBox(height: 20,),

                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20), width: double.infinity,
                    child: FlatButton(
                      child: Text("회원 가입"),
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: !_isSubmittable ? null : () async {
                        if(_formKey.currentState.validate() == false) return;

                        try {
                          // send request
                          setState(() {
                            _isSubmittable = false;
                          });

                          final res = await http.post(
                              Global.server_address + '/api/customers',
                              body: {
                                'values': json.encode({
                                  'email': _emailCtr.text,
                                  'name': _nameCtr.text,
                                  'address': _addressCtr.text,
                                  'password': _passCtr.text
                                })
                              }
                          );

                          // check response
                          if (res.statusCode ~/ 100 == 2) {
                            // 성공 했음
                            Navigator.pop(context, null);
                            return;
                          }

                          // 실패시
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("요청이 실패 했습니다.\n${json.decode(
                                    res.body)['message']}"),
                                duration: Duration(seconds: 1),
                              )
                          );
                          setState(() {
                            _isSubmittable = true;
                          });
                        } catch(e) {
                          _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("에러\n${e.toString()}"),
                            duration: Duration(seconds: 1),
                          )
                          );
                        }

                      },
                    ),
                  )

                ],)),
          ),
        )
    );
  }


  Widget _buildFieldWidget(String name, TextEditingController ctr, Function validator, {bool isObscureText = false})
  {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(children: <Widget>[
        SizedBox(width: 90, child: Text(name, style: TextStyle(fontSize: 20),)),
        SizedBox(width: 20,),
        Expanded(
            child: TextFormField(
              controller: ctr,
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.all(9)),
              validator: validator,
              obscureText: isObscureText,
            ))
      ]),
    );
  }
}
