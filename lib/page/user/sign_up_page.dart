import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:smart_life_lw/config.dart';
import 'package:smart_life_lw/network/user.dart';
import 'package:smart_life_lw/routes.dart';
import 'package:smart_life_lw/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_life_lw/network/sign_up.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  BuildContext _context;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _username, _phone, _password;
  bool _isObscure = true;
  Color _eyeColor;
  bool _isAgree = false;
  int _genderValue = 0;

  _request() async {
    var result = await SignUpUtils.signUp(SignUpInfo(
        username: _username,
        phone: _phone,
        password: _password,
        gender: _genderValue));
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(result.info)));
    if (result.code == 200) {
      Toast.show(_context, '注册成功～');
      // 保存用户数据
      GlobalConfig.userId = result.data;
      result = await UserUtils.getUserInfo(result.data);
      if (result.code == 200) GlobalConfig.userInfo = result.data;
      // 跳转到主页
      Navigator.pushReplacementNamed(context, UIRoute.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          children: <Widget>[
            SizedBox(
              height: kToolbarHeight,
            ),
            buildTitle(),
            buildTitleLine(),
            SizedBox(height: 70.0),
            buildUserNameTextField(),
            buildPhoneTextField(),
            buildPasswordTextField(context),
            buildGender(context),
            buildLicense(context),
            SizedBox(height: 60.0),
            buildMainButton(context),
            SizedBox(height: 30.0),
            buildGoLoginText(context),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Align buildGoLoginText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('已有账号？'),
            GestureDetector(
              child: Text(
                '立即登录',
                style: TextStyle(color: Colors.green),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, UIRoute.login_page);
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildUserNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '用户名称',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入用户名！';
        }
      },
      onSaved: (String value) => _username = value,
    );
  }

  TextFormField buildPhoneTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: '手机号码',
      ),
      validator: (String value) {
//        var emailReg = RegExp(r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        var phoneReg = RegExp(r"[0-9]{11}");
        if (!phoneReg.hasMatch(value)) {
          return '请输入正确的手机号码';
        }
      },
      onSaved: (String value) => _phone = value,
    );
  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _password = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入密码';
        }
      },
      decoration: InputDecoration(
        labelText: '密码',
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure
                ? GroovinMaterialIcons.eye
                : GroovinMaterialIcons.eye_off,
            color: _eyeColor,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
              _eyeColor =
                  _isObscure ? Colors.grey : Theme.of(context).iconTheme.color;
            });
          },
        ),
      ),
    );
  }

  Widget buildGender(BuildContext context) {
    var genderValueChange = (value) {
      _genderValue = value;
      setState(() {});
    };

    return Row(
      children: <Widget>[
        Text('选择性别：'),
        Radio(
          value: 0,
          groupValue: _genderValue,
          onChanged: genderValueChange,
        ),
        Text('未指定'),
        Radio(
          value: 1,
          groupValue: _genderValue,
          onChanged: genderValueChange,
        ),
        Text('男'),
        Radio(
          value: 2,
          groupValue: _genderValue,
          onChanged: genderValueChange,
        ),
        Text('女'),
      ],
    );
  }

  Widget buildLicense(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Checkbox(
              value: _isAgree,
              onChanged: (value) {
                setState(() {
                  _isAgree = value;
                });
              },
            ),
            Text('同意'),
            GestureDetector(
              child: Text('《汇智Life软件许可及服务协议》',
                  style: TextStyle(color: Colors.green)),
              onTap: () async {
                const url = 'https://flutter.io';
                if (await canLaunch(url))
                  await launch(url);
                else
                  throw 'Could not launch $url';
              },
            ),
            Text('与'),
            GestureDetector(
              child:
                  Text('《汇智Life隐私保护指引》', style: TextStyle(color: Colors.green)),
              onTap: () async {
                const url =
                    'http://47.106.203.63/group1/M00/00/00/hzlife/privacy.html';
                if (await canLaunch(url))
                  await launch(url);
                else
                  throw 'Could not launch $url';
              },
            ),
          ],
        ),
      ),
    );
  }

  Align buildMainButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          shape: StadiumBorder(side: BorderSide()),
          child: Text(
            '注册',
//            style: Theme.of(context).primaryTextTheme.headline,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              if (_isAgree) {
                _formKey.currentState.save();
                _request();
                print('phone:$_phone , assword:$_password');
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text('必须同意服务协议才可以注册！'),
                  duration: Duration(milliseconds: 1000),
                ));
              }
            }
          },
        ),
      ),
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.black,
          width: 80.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '注册',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
}
