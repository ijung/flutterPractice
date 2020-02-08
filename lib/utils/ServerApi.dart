import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Global.dart';


class ServerApi {
  static void fetchCustomerHasItems () async
  {
    final res = await requestGet(
        '/api/customer-has-items',
        {
        'options': json.encode({
          'where': {
            'customer_id': Global.id,
          }
        }),
        },
        token: Global.token
    );

    print(res.body);

  }
  static Future<List<ItemResponse>> fetchItems(Map<String, dynamic> query) async {
    final res = await requestGet(
      '/api/items',
      {
        'options': json.encode(query),
      }
    );
    print(res.body);
    return json.decode(res.body)['items'].map<ItemResponse>((item) {
      return ItemResponse.fromJson(item);
    }).toList();
  }
  static Future<LoginResponse> login (String email, String password) async {
    final res = await requestPost(
      '/api/login',
      {
        'type': 'CUSTOMER',
        'login_id': email,
        'password': password,
      }
    );
    return LoginResponse.fromJson(json.decode(res.body)['items'][0]);
  }
  static Future<void> registerCustomer (String email, String name, String address, String password) async {
    return await requestPost(
      '/api/customers',
      {
        'values': json.encode({
          'email'   : email   ,
          'name'    : name    ,
          'address' : address ,
          'password': password,
        }),
      },
    );
  }

  static Future<http.Response> requestPost (String path, Map<String, String> body, {String token}) async {
    final headers = Map<String, String>();
    final res = await http.post(
      Global.server_address + path,
      body: body,
      headers: headers,
    );
    print(json.decode(res.body));
    return _request_tail(res);
  }

  static Future<http.Response> requestGet (String path, Map<String, String> query, {String token}) async {
    final uri = Uri(queryParameters: query);
    final headers = Map<String, String>();
    if(token != null) headers['x-api-key'] = token;
    final res = await http.get(
      Global.server_address + path + '?' + uri.query,
      headers: headers
    );
    return _request_tail(res);
  }

  static http.Response _request_tail (http.Response res) {
    if (res.statusCode ~/ 100 == 2) {
      return res;
    }

    throw ServerApiException(res);
  }
}

class ServerApiException implements Exception {
  http.Response response;
  ServerApiException(this.response);
}

class LoginResponse {
  int id;
  String role;
  String token;

  LoginResponse(this.id, this.role, this.token);
  factory LoginResponse.fromJson (Map<String, dynamic> json) {
    return LoginResponse(json['id'], json['role'], json['token']);
  }
}

class ItemResponse {
  int id;
  String title;
  String description;
  int price;
  String image;
  String detail_contents;

  ItemResponse(this.id, this.title, this.description, this.price, this.image,
      this.detail_contents);

  factory ItemResponse.fromJson(Map<String, dynamic> json) {
    return ItemResponse(
      json['id'],
      json['title'],
      json['description'],
      json['price'],
      json['image'],
      json['detail_contents']
    );
  }


}