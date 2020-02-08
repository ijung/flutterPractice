import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app_001/widgets/LoadingWrapper.dart';

class HttpTest extends StatefulWidget {
  @override
  _HttpTestState createState() => _HttpTestState();
}

class _HttpTestState extends State<HttpTest> {
  bool _isLoading = false;
  String _response = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Http Test'),),
      body: LoadingWrapper(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('테스트'),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    final res = await _fetch();

                    setState(() {
                      _isLoading = false;
                      _response = 'status: ${res.statusCode}\n\n${res.body}';
                    });
                  }
                  catch(e) {
                    Text("error");
                  }
                },
              ),

              SizedBox(height: 20,),

              Text(_response),

              /*
            // 결과 텍스트
            FutureBuilder<http.Response>(
              future: _fetch(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  // 성공시
                  return Text(snapshot.data.body);
                }
                if(snapshot.hasError) {
                  return Text("에러");
                  // 실패시
                }
                return CircularProgressIndicator();
                // 로딩 중
              }
            ),
             */
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> _fetch() async {
    await Future.delayed(Duration(seconds: 5));
    return await http.get("http://1.234.4.139:3300/api/items");
  }
}