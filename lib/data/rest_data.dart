import 'dart:async';

import 'package:flutter_mvp_app/models/User.dart';
import 'package:flutter_mvp_app/utils/NetworkUtils.dart';

class RestData{
  NetworkUtils  networkUtils=new NetworkUtils();
  static final BASE_URL="http://api.pickcargo.in/api/";
  static final LOGIN_URL=BASE_URL+"/master/customer/login";

  Future<User> login(String username,String password){
    return new Future.value(new User(username,password));
  }
}