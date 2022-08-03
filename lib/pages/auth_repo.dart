import 'dart:html';

import 'package:keycloak_login_poc/util/auth.enum.dart';
import 'package:keycloak_login_poc/util/env.dart';
import 'dart:convert';
import 'package:matp/pages/env.dart';


import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';


class AuthRepository {
Future<AuthenticationResponse> login(String username, String password) async {
  String url = Environment.SSO_URL + '/protocol/openid-connect/token';
  Map<String, String> headers = {
    'content-type': 'application/x-www-form-urlencoded',
    'cache-control': 'no-cache',
  };
Map<String, String> data = {
  'client_id': Environment.CLIENT_ID,
  'username': username,
  'password': password,
  'grant_type': 'password'
};
http.Response response = await http.post(url, headers: headers, body: data);
print(response.body);
print(response.statusCode);


if (response.statusCode == 200) {
  dynamic toekn = json.decode(response.body);
  return AuthenticationResponse.AUTHENTICATED;
}else if (response.statusCode == 401){
  return throw ("NOT_AUTHORIZES");
} else if (response.statusCode == 400){
    return throw ("NEED_EMAIL_VERIFICATION")
} else {
  throw ('Server Error');
}
}
}

// String url = Environement.SSO_URL + ‘/protocol/openid-connect/token’;





