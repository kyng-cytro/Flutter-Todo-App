import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/auth/functions/auth_state.dart';
import 'package:todo_app/general/widgets/input_with_icon.dart';
import 'package:todo_app/general/widgets/outlined_button.dart';
import 'package:todo_app/general/widgets/primary_button.dart';
import 'package:todo_app/general/widgets/restart_widget.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  TextEditingController _signinemail = TextEditingController();
  TextEditingController _signinpassword = TextEditingController();
  TextEditingController _signupname = TextEditingController();
  TextEditingController _signupemail = TextEditingController();
  TextEditingController _signuppassword = TextEditingController();
  TextEditingController _code = TextEditingController();
  TextEditingController _add = TextEditingController();
  int _pageState = 0;
  bool _isloading = false;
  var _backgroundColor = Colors.white;
  var _headingColor = Color(0xFFB40284A);

  double _headingTop = 50;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerXOffset = 0;
  double _registerHeight = 0;
  double _registerWidth = 0;
  double _registerOpacity = 1;
  double _completeYOffset = 0;
  double _completeHeight = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  bool _keyboardVisible = false;

  @override
  void initState() {
    super.initState();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardVisible = visible;
        print("Keyboard State Changed : $visible");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthState _state = Provider.of<AuthState>(context, listen: false);
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;
    _loginHeight = windowHeight - 170;
    _registerHeight = windowHeight - 170;

    switch (_pageState) {
      case 0:
        _backgroundColor = Color(0xffbbc2d8);
        _headingColor = Color(0xff0a1551);

        _headingTop = 50;

        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _registerOpacity = 1;

        _loginYOffset = windowHeight;
        _loginHeight = _keyboardVisible ? windowHeight : windowHeight - 170;

        _loginXOffset = 0;
        _registerXOffset = 0;
        _completeYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _registerWidth = windowWidth;
        _completeHeight = windowHeight;
        break;
      case 1:
        _backgroundColor = Color(0xff7d80aa);
        _headingColor = Colors.white;

        _headingTop = 40;

        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _registerOpacity = 1;
        _loginYOffset = _keyboardVisible
            ? (6.76 / 100) * windowHeight
            : (28.72 / 100) * windowHeight;
        _loginHeight = _keyboardVisible
            ? windowHeight
            : windowHeight - ((28.72 / 100) * windowHeight);

        _loginXOffset = 0;
        _registerYOffset = windowHeight;
        _registerWidth = windowWidth;
        _completeHeight = windowHeight;
        _completeYOffset = windowHeight;
        break;
      case 2:
        _backgroundColor = Color(0xff7d80aa);
        _headingColor = Colors.white;

        _headingTop = 30;

        _loginWidth = windowWidth - 40;
        _loginOpacity = 0.7;
        _registerOpacity = 1;
        _loginYOffset = _keyboardVisible
            ? (5.07 / 100) * windowHeight
            : (23.65 / 100) * windowHeight;
        _loginHeight = _keyboardVisible
            ? windowHeight
            : windowHeight - ((23.65 / 100) * windowHeight);

        _loginXOffset = 20;
        _registerWidth = windowWidth;
        _registerYOffset = _keyboardVisible
            ? (9.29 / 100) * windowHeight
            : (28.72 / 100) * windowHeight;
        _registerHeight = _keyboardVisible
            ? windowHeight
            : windowHeight - ((28.72 / 100) * windowHeight);
        _completeHeight = windowHeight;
        _completeYOffset = windowHeight;
        break;

      case 3:
        _backgroundColor = Color(0xff7d80aa);
        _headingColor = Colors.white;

        _headingTop = 30;

        _loginWidth = windowWidth;
        _loginOpacity = 1;
        _registerOpacity = 0.7;
        _loginYOffset = windowHeight;

        _loginXOffset = 0;
        _registerXOffset = 20;
        _registerWidth = windowWidth - 40;
        _registerYOffset = _keyboardVisible
            ? (5.07 / 100) * windowHeight
            : (23.65 / 100) * windowHeight;
        _registerHeight = _keyboardVisible
            ? windowHeight
            : windowHeight - ((23.65 / 100) * windowHeight);

        _completeYOffset = _keyboardVisible
            ? (9.29 / 100) * windowHeight
            : (28.72 / 100) * windowHeight;
        _completeHeight = _keyboardVisible
            ? windowHeight
            : windowHeight - ((28.72 / 100) * windowHeight);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                color: _backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: Duration(milliseconds: 1000),
                            margin: EdgeInsets.only(
                              top: _headingTop,
                            ),
                            child: Text(
                              "Never Forget",
                              style:
                                  TextStyle(color: _headingColor, fontSize: 28),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              "That you can now focus on the task at hand as we will remind what's next.",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: _headingColor, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Center(
                        child: Image.asset("assets/images/splash_bg.png"),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_pageState != 0) {
                              _pageState = 0;
                            } else {
                              _pageState = 1;
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFB40284A),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Get Started",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            AnimatedContainer(
              padding: EdgeInsets.all(32),
              width: _loginWidth,
              height: _loginHeight,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform:
                  Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_loginOpacity),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Login To Continue",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      InputWithIcon(
                        icon: Icons.email,
                        hint: "Enter Email...",
                        password: false,
                        controller: _signinemail,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.vpn_key,
                        hint: "Enter Password...",
                        password: true,
                        controller: _signinpassword,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if (_signinemail.text != "" &&
                              _signinpassword.text != "") {
                            setState(() {
                              _isloading = true;
                            });
                            var res = await _state.login(
                                _signinemail.text, _signinpassword.text);
                            if (res == true) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("loggedin", true);
                              setState(() {
                                _isloading = false;
                              });
                              RestartWidget.restartApp(context);
                              //Navigator.of(context).pushReplacementNamed("/home");
                            } else {
                              final snackBar = SnackBar(
                                content: Text(res.message),
                              );
                              setState(() {
                                _isloading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Please enter vaild credentials')));
                          }
                        },
                        child: PrimaryButton(
                          btnText: "Login",
                          isloading: _isloading,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageState = 2;
                            _signinemail.clear();
                            _signinpassword.clear();
                          });
                        },
                        child: OutlineBtn(
                          btnText: "Create New Account",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              height: _registerHeight,
              width: _registerWidth,
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(
                  _registerXOffset, _registerYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(_registerOpacity),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Create a New Account",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      InputWithIcon(
                        icon: Icons.email,
                        hint: "Enter Email...",
                        password: false,
                        controller: _signupemail,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.vpn_key,
                        hint: "Enter Password...",
                        password: true,
                        controller: _signuppassword,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if (_signupemail.text != "" &&
                              _signuppassword.text != "") {
                            setState(() {
                              _isloading = true;
                            });
                            var res = await _state.createaccount("User",
                                _signupemail.text, _signuppassword.text);
                            if (res == true) {
                              setState(() {
                                _isloading = false;
                                _pageState = 3;
                              });
                            } else {
                              final snackBar = SnackBar(
                                content: Text(res.message),
                              );
                              setState(() {
                                _isloading = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Please input your email and a vaild password.')));
                          }
                        },
                        child: PrimaryButton(
                          btnText: "Create Account",
                          isloading: _isloading,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _pageState = 1;
                            _signupemail.clear();
                            _signuppassword.clear();
                          });
                        },
                        child: OutlineBtn(
                          btnText: "Back To Login",
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              height: _completeHeight,
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _completeYOffset, 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Complete Account Creation",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      InputWithIcon(
                        icon: Icons.person,
                        hint: "Enter Name...",
                        password: false,
                        controller: _signupname,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.map,
                        hint: "Address...",
                        password: false,
                        controller: _add,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        icon: Icons.verified,
                        hint: "Code Sent to Email...",
                        password: false,
                        controller: _code,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if (_signupname.text != "") {
                            setState(() {
                              _isloading = true;
                            });
                            var res =
                                await _state.updateaccount(_signupname.text);
                            if (res == true) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool("loggedin", true);
                              setState(() {
                                _isloading = false;
                              });
                              RestartWidget.restartApp(context);
                            } else {
                              setState(() {
                                _isloading = false;
                              });
                              final snackBar = SnackBar(
                                content: Text(res.message),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Please enter a vaild full-name')));
                          }
                        },
                        child: PrimaryButton(
                          btnText: "Update Details",
                          isloading: _isloading,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
