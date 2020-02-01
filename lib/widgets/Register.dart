import 'package:flutter/material.dart';


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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
                _buildFieldWidget("이메일", _emailCtr, (v) {
                  if(v.trim() == '') return '값을 입력해 주세요';
                  if(v.indexOf('@') == -1) return '이메일 형식이 아닙니다.';
                  return null;}),
                _buildFieldWidget("비밀번호", _passCtr, (v) {if(v.trim() == '') return '값을 입력해 주세요'; return null;}),
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
                      print("성공!");

                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("요청 중"),
                          duration: Duration(seconds: 15),
                        )
                      );

                      setState(() {
                        _isSubmittable = false;
                      });

                      await Future.delayed(Duration(seconds: 1));
                      _scaffoldKey.currentState.removeCurrentSnackBar();

                      await Future.delayed(Duration(seconds: 2));
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("요청이 실패 했습니다."),
                            duration: Duration(seconds: 1),
                          )
                      );
                      setState(() {
                        _isSubmittable = true;
                      });

                    },
                  ),
                )

              ],)),
        )
    );
  }


  Widget _buildFieldWidget(String name, TextEditingController ctr, Function validator)
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
            ))
      ]),
    );
  }
}
