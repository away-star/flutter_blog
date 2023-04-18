// import 'dart:html' show window;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_blog/services/checkAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constants.dart';
import '../../components/SliderDialog.dart';
import '../home/home.dart';
import 'custom_route.dart';



class LoginScreen extends StatelessWidget {
  //定义路由名称
  static const routeName = '/auth';
  final CheckAPI checkAPI = CheckAPI();

  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  //登录
  Future<String?> _loginUser(BuildContext context, LoginData data) {
    return verifySlider(context).then((verified) async {
      if (!verified) {
        return 'Slider verification failed';
      }
      var response = await checkAPI.login(data.name, data.password);
      if (response['code'] == 200) {
        print(response);
        String token = response['data']['access_token'];
        if (kIsWeb) {
          //SharedPreferences prefs = await SharedPreferences.getInstance();
          // web端可以使用localStorage存储
           //window.localStorage['Authorization'] = "Bearer "+token;
        } else {
          // 移动平台和桌面平台可以使用SharedPreferences存储
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('Authorization', "Bearer "+token);
        }
      } else {
        return response['msg'];
      }
      return null;
    });
  }

  //滑动验证
  Future<bool> verifySlider(BuildContext context) async {
    // Generate a random number between 0 and 100
    final int randomNumber = 1 + Random().nextInt(9);
    // Show a dialog with a slider that goes from 0 to 100
    return true;
    // 这里为了方便调试，先去掉的防爆破!!??！！？？
    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SliderDialog(randomNumber: randomNumber, maxNumber: 10,);
      },
    );
    // Check if the user slid the slider correctly
    return result == randomNumber;
  }

  //注册
  Future<String?> _signupUser(SignupData data) async {
    var response = await checkAPI.getRegisterCaptcha(data.name!);
    if (response['code'] == 200) {
      return null;
    }
    return response['msg'];
  }

  //找回密码
  Future<String?> _recoverPassword(String email) async {

    var response = await checkAPI.getRecoverCaptcha(email);
    print(response);
    if (response['code'] == 200) {
      return null;
    }
    return response['msg'];
  }

  Future<String?> _signupConfirm(String captcha, LoginData data) async {
    // return Future.delayed(loginTime).then((_) {
    //   print(data);
    //   return null;
    // });
    var response = await checkAPI.register(data.name, captcha, data.password);
    if (response['code'] == 200) {
      return null;
    }
    return response['msg'];
  }

  Future<String?> _recoverConfirm(String captcha, LoginData data) async {
    var response = await checkAPI.recover(data.name, captcha, data.password);
    if (response['code'] == 200) {
      return null;
    }
    return response['msg'];
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // title: Constants.appName,
      logo: const AssetImage('assets/images/logo.png'),
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      onConfirmRecover: _recoverConfirm,
      onConfirmSignup: _signupConfirm,
      loginAfterSignUp: true,
      loginProviders: [
        // LoginProvider(
        //   button: Buttons.linkedIn,
        //   label: 'Sign in with LinkedIn',
        //   callback: () async {
        //     return null;
        //   },
        //   providerNeedsSignUpCallback: () {
        //     // put here your logic to conditionally show the additional fields
        //     return Future.value(true);
        //   },
        // ),
        LoginProvider(
          icon: FontAwesomeIcons.weixin,
          label: 'Wechat',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.qq,
          label: 'QQ',
          callback: () async {
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.githubAlt,
          label: 'Github',
          callback: () async {
            debugPrint('start github sign in');
            await Future.delayed(loginTime);
            debugPrint('stop github sign in');
            return null;
          },
        ),
      ],
      termsOfService: [
        TermOfService(
          id: 'newsletter',
          mandatory: false,
          text: 'Newsletter subscription',
        ),
        TermOfService(
          id: 'general-term',
          mandatory: true,
          text: '用户隐私安全协议',
          linkUrl: 'https://github.com/NearHuscarl/flutter_login',
        ),
      ],
      // additionalSignupFields: [
      //   const UserFormField(
      //     keyName: 'Username',
      //
      //     icon: Icon(FontAwesomeIcons.userLarge),
      //   ),
      //   const UserFormField(keyName: 'Name'),
      //   const UserFormField(keyName: 'Surname'),
      //   UserFormField(
      //     keyName: 'phone_number',
      //     displayName: 'Phone Number',
      //     userType: LoginUserType.phone,
      //     fieldValidator: (value) {
      //       final phoneRegExp = RegExp(
      //         '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
      //       );
      //       if (value != null &&
      //           value.length < 7 &&
      //           !phoneRegExp.hasMatch(value)) {
      //         return "This isn't a valid phone number";
      //       }
      //       return null;
      //     },
      //   ),
      // ],
      // scrollable: true,
      // hideProvidersTitle: false,
      // loginAfterSignUp: false,
      // hideForgotPasswordButton: true,
      // hideSignUpButton: true,
      // disableCustomPageTransformer: true,
      // messages: LoginMessages(
      //   userHint: 'User',
      //   passwordHint: 'Pass',
      //   confirmPasswordHint: 'Confirm',
      //   loginButton: 'LOG IN',
      //   signupButton: 'REGISTER',
      //   forgotPasswordButton: 'Forgot huh?',
      //   recoverPasswordButton: 'HELP ME',
      //   goBackButton: 'GO BACK',
      //   confirmPasswordError: 'Not match!',
      //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
      //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      //   recoverPasswordSuccess: 'Password rescued successfully',
      //   flushbarTitleError: 'Oh no!',
      //   flushbarTitleSuccess: 'Succes!',
      //   providersTitle: 'login with'
      // ),
      // theme: LoginTheme(
      //   primaryColor: Colors.teal,
      //   accentColor: Colors.yellow,
      //   errorColor: Colors.deepOrange,
      //   pageColorLight: Colors.indigo.shade300,
      //   pageColorDark: Colors.indigo.shade500,
      //   logoWidth: 0.80,
      //   titleStyle: TextStyle(
      //     color: Colors.greenAccent,
      //     fontFamily: 'Quicksand',
      //     letterSpacing: 4,
      //   ),
      //   // beforeHeroFontSize: 50,
      //   // afterHeroFontSize: 20,
      //   bodyStyle: TextStyle(
      //     fontStyle: FontStyle.italic,
      //     decoration: TextDecoration.underline,
      //   ),
      //   textFieldStyle: TextStyle(
      //     color: Colors.orange,
      //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      //   ),
      //   buttonStyle: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.yellow,
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.yellow.shade100,
      //     elevation: 5,
      //     margin: EdgeInsets.only(top: 15),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(100.0)),
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.purple.withOpacity(.1),
      //     contentPadding: EdgeInsets.zero,
      //     errorStyle: TextStyle(
      //       backgroundColor: Colors.orange,
      //       color: Colors.white,
      //     ),
      //     labelStyle: TextStyle(fontSize: 12),
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //     errorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedErrorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
      //       borderRadius: inputBorder,
      //     ),
      //     disabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //   ),
      //   buttonTheme: LoginButtonTheme(
      //     splashColor: Colors.purple,
      //     backgroundColor: Colors.pinkAccent,
      //     highlightColor: Colors.lightGreen,
      //     elevation: 9.0,
      //     highlightElevation: 6.0,
      //     shape: BeveledRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
      //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
      //   ),
      // ),
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        // final userExists = await checkIfUserExists(value);
        // if (userExists) {
        //   return 'User already exists';
        // }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        debugPrint('Login info');
        debugPrint('Name: ${loginData.name}');
        debugPrint('Password: ${loginData.password}');
        return _loginUser(context, loginData);
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');
        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (final element in signupData.termsOfService) {
            debugPrint(
              ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
            );
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => Home(),
          ),
        );
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      headerWidget: const IntroWidget(),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "You are trying to login/sign up on server hosted on ",
              ),
              TextSpan(
                text: "example.com",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          textAlign: TextAlign.justify,
        ),
        Row(
          children: const <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Authenticate"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
