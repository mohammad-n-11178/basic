
import 'package:basic_project/providers/auth_provider.dart';
import 'package:basic_project/providers/language_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/constants.dart';
import '../shared/login_features.dart';
import 'package:flutter/services.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl; //this for auto dirctionality

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  bool _rememberMe = false;
  bool passwordVisabale = true;
  bool _isloading = false;

  //start form controller
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController phonenumber = new TextEditingController();

  String error;

  GlobalKey<FormState> formstatesignin = new GlobalKey<FormState>();
  GlobalKey<FormState> formstatesignup = new GlobalKey<FormState>();

  // ignore: missing_return
  String validglobal(String val) {
    if (val.trim().isEmpty) {
      return 'NOOOOOOOOO EMpty';
    }
  }

  // ignore: missing_return
  String validusernameAndName(String val) {
    if (val.isEmpty) {
      return "username can't be empty";
    }
    if (val.length < 6) {
      return "username can't be less than 4 letters";
    }
    if (val.length > 50) {
      return "username can't be more than 50 letters";
    }
  }

  // ignore: missing_return
  String validEmail(String val) {
    if (val.isEmpty) {
      return "email can't be empty";
    }
    if (val.length < 4) {
      return "email can't be less than 4 letters";
    }
    if (val.length > 50) {
      return "email can't be more than 50 letters";
    }
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val)) {
      return "email not valid";
    }
  }

  // ignore: missing_return
  String validpassword(String val) {
    if (val.isEmpty) {
      return "password can't be empty";
    }
    if (val.length < 8) {
      return "password can't be less than 8 charecters";
    }
    if (val.length > 30) {
      return "password can't be more than 30 letters";
    }
  }

  // ignore: missing_return
  String validconfirmpassword(String val) {
    if (val != password.text) {
      return "passwords does not match";
    }
  }

  TapGestureRecognizer _changesign; // to change sign in/up
  bool showsignin = true;

  void _showErrorDialog(String message, List errorList) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        content: Container(
          height: 100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...errorList.map((catdata) => Text(catdata.toString())).toList()
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                errorList.clear();
              },
              child: Text("Okay"))
        ],
      ),
    );
  }

  void submitSignUp() async {
    final isValid = formstatesignup.currentState.validate();
    print("formstatesignup is valid {$isValid}");
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        print("valiiiiiiid");
        setState(() {
          _isloading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false).signUp(
            email.text,
            password.text,
            confirmpassword.text,
            username.text,
            name.text,
            phonenumber: phonenumber.text);
        setState(() => _isloading = false);
      } catch (error) {
        setState(() => _isloading = false);
        _showErrorDialog(error,
            Provider.of<AuthProvider>(context, listen: false).finalErrorsList);
      }
    }
  }

  @override
  void initState() {
    _changesign = new TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          showsignin = !showsignin;
          print(showsignin);
        });
      };

    super.initState();
  }

//     var mdw = MediaQuery.of(context).size.width;
//     var mdh = MediaQuery.of(context).size.height ;

  @override
  Widget build(BuildContext context) {
    var txt = Provider.of<LanguageProvider>(context);

    SizedBox _buildSizedBox(double height) => SizedBox(height: height);

    Widget _buildForm() {
      return Form(
        key: showsignin ? formstatesignin : formstatesignup,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              txt.getTexts('email'),
              style: kLabelStyle,
            ),
            SizedBox(height: 5.0),
            Container(
              alignment: Alignment.centerLeft,
              decoration: kBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: email,
                validator: validEmail,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: txt.getTexts('enter_your_email'),
                  hintStyle: kHintTextStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            if (!showsignin)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    txt.getTexts('username'),
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      controller: username,
                      validator: validusernameAndName,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: txt.getTexts('enter_your_username'),
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            if (!showsignin) SizedBox(height: 15.0),
            if (!showsignin)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    txt.getTexts('name'),
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      controller: name,
                      validator: validusernameAndName,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.contacts,
                          color: Colors.white,
                        ),
                        hintText: txt.getTexts('enter_your_name'),
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 15.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  txt.getTexts('password'),
                  style: kLabelStyle,
                ),
                SizedBox(height: 5.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 50.0,
                  child: TextFormField(
                    controller: password,
                    validator: validpassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14.0),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: txt.getTexts('enter_your_password'),
                      hintStyle: kHintTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            if (!showsignin) SizedBox(height: 15.0),
            if (!showsignin)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    txt.getTexts('confirm_password'),
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    height: 50.0,
                    child: TextFormField(
                      controller: confirmpassword,
                      validator: validconfirmpassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        hintText: txt.getTexts('enter_your_password_again'),
                        hintStyle: kHintTextStyle,
                      ),
                    ),
                  ),
                ],
              ),

            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text(
            //       txt.getTexts('phonenumber'),
            //       style: kLabelStyle,
            //     ),
            //     SizedBox(height: 5.0),
            //     Container(
            //       alignment: Alignment.centerLeft,
            //       decoration: kBoxDecorationStyle,
            //       height: 50.0,
            //       child: TextFormField(
            //         controller: phonenumber,
            //         validator: validpassword,
            //         obscureText: false,
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontFamily: 'OpenSans',
            //         ),
            //         decoration: InputDecoration(
            //           border: InputBorder.none,
            //           contentPadding: EdgeInsets.only(top: 14.0),
            //           prefixIcon: Icon(
            //             Icons.phone_android,
            //             color: Colors.white,
            //           ),
            //           hintText: txt.getTexts('enter_your_phonenumber'),
            //           hintStyle: kHintTextStyle,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      );
    }

    _buildforgetpasswordDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // backgroundColor: Color(0xFF73AEF5) ,
              title: Text(txt.getTexts("reset_password")),
              content: Container(
                height: 130,
                child: Column(
                  children: [
                    Text(txt.getTexts("reset_password_body")),
                    TextFormField(
                      controller: email,
                      validator: validEmail,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontFamily: 'OpenSans',
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(txt.getTexts('submit')),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () {
                      return Navigator.of(context).pop();
                    },
                    child: Text(txt.getTexts('cancel')))
              ],
            );
          });
    }

    Widget _buildOrText() {
      return Column(
        children: <Widget>[
          Text(
            '- OR -',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockHorizontal * 2),
        ],
      );
    }

    Widget _buildLoginBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        // ignore: deprecated_member_use
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            return Provider.of<AuthProvider>(context, listen: false)
                .logIn(email.text, password.text);
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            txt.getTexts('sign_in'),
            style: TextStyle(
              color: Color(0xFF61A4F1),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }

    Widget _buildLogUpBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        // ignore: deprecated_member_use
        child: RaisedButton(
          elevation: 5.0,
          onPressed: submitSignUp,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            txt.getTexts('sign_up'),
            style: TextStyle(
              color: Color(0xFF478DE0),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }

    Widget _buildGoogleButton() {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: deprecated_member_use
            new RaisedButton(
                color: Colors.white,
                elevation: 0.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                padding: EdgeInsets.only(
                    top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                onPressed: () {
                  setState(() => _isloading = true);
                },
                child:
                    new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                    child: Text(
                      txt.getTexts('continue_with_google'),
                      style: TextStyle(
                        color: Color(0xFF478DE0),
                        letterSpacing: 1.1,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  new Image.asset(
                    'assets/images/google_logo.png',
                    height: 35.0,
                    width: 35.0,
                  ),
                ]))
          ]);
    }

    Widget _buildFacebookButton() {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: deprecated_member_use
            new RaisedButton(
                color: Colors.white,
                elevation: 0.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                padding: EdgeInsets.only(
                    top: 7.0, bottom: 7.0, right: 40.0, left: 7.0),
                onPressed: () {
                  setState(() => _isloading = true);
                },
                child:
                    new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                    child: Text(
                      txt.getTexts('continue_with_facebook'),
                      style: TextStyle(
                        color: Color(0xFF478DE0),
                        letterSpacing: 1.1,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  new Image.asset(
                    'assets/images/facebook.png',
                    height: 35.0,
                    width: 35.0,
                  ),
                ]))
          ]);
    }

    Widget _buildForgotPasswordBtn() {
      return Container(
        alignment: Alignment.centerRight,
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: () => _buildforgetpasswordDialog(),
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            txt.getTexts('forget_password_btn'),
            style: kLabelStyle,
          ),
        ),
      );
    }

    // ignore: unused_element
    Widget _buildRememberMeCheckbox() {
      return Container(
        height: 20.0,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: _rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value;
                  });
                },
              ),
            ),
            Text(
              'Remember me',
              style: kLabelStyle,
            ),
          ],
        ),
      );
    }

    Widget _buildSignInUP() {
      return Container(
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: showsignin
                    ? (txt.getTexts('donot_have_account'))
                    : (txt.getTexts('Already_you_have_account')),
                style: TextStyle(fontSize: 14, letterSpacing: 0.3)),
            TextSpan(
                recognizer: _changesign,
                text: showsignin
                    ? txt.getTexts('create_new_account')
                    : txt.getTexts('sign_in'),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Cairo"))
          ]),
        ),
      );
    }

    SizeConfig().init(context);

    return Directionality(
        textDirection:
            intl.Bidi.detectRtlDirectionality(txt.getTexts("test_direction"))
                ? TextDirection.rtl
                : TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF73AEF5),
                            Color(0xFF61A4F1),
                            Color(0xFF478DE0),
                            Color(0xFF398AE5),
                          ],
                          stops: [0.1, 0.4, 0.7, 0.9],
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal * 8,
                          vertical: SizeConfig.safeBlockVertical * 5,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              showsignin
                                  ? txt.getTexts('sign_in')
                                  : txt.getTexts('sign_up'),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height: showsignin
                                    ? SizeConfig.safeBlockVertical * 7
                                    : SizeConfig.safeBlockVertical * 4),
                            _buildForm(),
                            showsignin
                                ? _buildForgotPasswordBtn()
                                : _buildSizedBox(
                                    SizeConfig.safeBlockVertical * 1.5),
                            showsignin ? _buildLoginBtn() : _buildLogUpBtn(),
                            _buildSizedBox(SizeConfig.safeBlockVertical * 0.1),
                            _isloading ? LoadingCircul() : _buildOrText(),
                            _buildSizedBox(showsignin
                                ? SizeConfig.safeBlockVertical * 2
                                : 0),
                            (showsignin) ? _buildGoogleButton() : SizedBox(),
                            _buildSizedBox(showsignin
                                ? SizeConfig.safeBlockVertical * 4
                                : 0),
                            (showsignin) ? _buildFacebookButton() : SizedBox(),
                            _buildSizedBox(showsignin
                                ? SizeConfig.safeBlockVertical * 4
                                : 0),
                            _buildSignInUP(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// Loading
class LoadingCircul extends StatelessWidget {
  const LoadingCircul({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CircularProgressIndicator(
      backgroundColor: Colors.white,
      strokeWidth: 3,
    ));
  }
}

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Your email address appears to be malformed.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}
