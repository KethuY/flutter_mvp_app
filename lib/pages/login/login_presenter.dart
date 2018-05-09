import 'package:flutter_mvp_app/data/rest_data.dart';
import 'package:flutter_mvp_app/models/User.dart';
abstract class LoginPageContract{
  void onLoginSuccess(User user);
  void onLoginError(String error);

}

class LoginPagePresenter{
  LoginPageContract _view;
  RestData restData=new RestData();

  LoginPagePresenter(this._view);

  doLogin(String username,String password){
    restData.login(username, password)
            .then((User user)=>_view.onLoginSuccess(user))
            .catchError((onError)=>_view.onLoginError(onError.toString()));
  }

}