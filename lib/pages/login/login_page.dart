import 'package:flutter/material.dart';
import 'package:flutter_mvp_app/data/database.dart';
import 'package:flutter_mvp_app/models/User.dart';
import 'package:flutter_mvp_app/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _buildContext;
  bool isLoading;
  final formerKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;
  LoginPagePresenter loginPagePresenter;

  _LoginPageState() {
    loginPagePresenter = new LoginPagePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;

    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.green,
    );

    var loginForm = new Column(
      children: <Widget>[
        new Text("Username"),
        new Form(
          key: formerKey,
          child: new Column(
            children: <Widget>[
              // ignore: const_constructor_field_type_mismatch
              new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new TextFormField(
                    onSaved: (val) => _username = val,
                    decoration: new InputDecoration(labelText: "Username"),
                  )),

              new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new TextFormField(
                    onSaved: (val) => _password = val,
                    decoration: new InputDecoration(labelText: "Password"),
                  )),
            ],
          ),
        ),
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError

    showSnackbar(error);

    setState(() {
      isLoading=false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    showSnackbar(user.toMap().toString());
    setState(() {
      isLoading=false;

    });

    var db=new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(_buildContext).pushNamed("/home");
  }

  void _submit() {
    final form = formerKey.currentState;

    if (form.validate()) {
      setState(() {
        isLoading = true;
        form.save();
        loginPagePresenter.doLogin(_username, _password);
      });
    }
  }

  void showSnackbar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }
}
