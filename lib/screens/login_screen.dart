import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_com/repository/auth_repo.dart';
import 'package:e_com/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import '../constants/styles.dart';
// import 'package:auth0_flutter/auth0_flutter.dart';

// final auth0 = Auth0(
//     'dev-eelswpexe381qxmf.us.auth0.com', 'z9m9x3otSdmeOvCvQFp5EhyIiulLYci2');

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const routeName = '/login';
  static Page page() => MaterialPage(child: LoginScreen());

  final authRepo = AuthRepo();

  Duration get loginTime => const Duration(milliseconds: 1000);
  FirebaseException? firebaseException;
  // String? email;

  Future<String?> _authUser(LoginData data) async {
    final result =
        await authRepo.login(email: data.name, password: data.password);
    return result;
  }

  Future<String?> _loginGoogle() async {
    // debugPrint('start google sign in');
    // await auth0.webAuthentication(scheme: 'demo').login();
    // await auth0.webAuthentication().login();

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId:
            '911595939692-ou0ftm92dchhbq0fja12kvt0tmmru0te.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential authCredentials = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        print('Auth Creds: $authCredentials');
        UserCredential result =
            await FirebaseAuth.instance.signInWithCredential(authCredentials);
        // User? user = result.user;
        // print('user: $authCredentials');
        return null;
      }
    } on PlatformException catch (e) {
      if (e.message!.contains('failed') ||
          e.message!.contains('ApiException')) {
        // print('Google sign in exception cought: ${e.message}');
        return e.message;
      }
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    authRepo.signUp(email: data.name, password: data.password);
  }

  Future<String?> _recoverPassword(String email) async {
    // debugPrint('Name: $name');
    authRepo.recoverPassword(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
        title: 'e-CART',
        // logo: const AssetImage('assets/images/google.png'),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context, rootNavigator: true)
              .pushReplacement(MaterialPageRoute(
            builder: (context) => const HomeScreen(title: 'e-CART'),
          ));
        },
        onRecoverPassword: _recoverPassword,
        theme: LoginTheme(
          primaryColor: Colors.deepPurple,
          accentColor: Colors.black,
          errorColor: Colors.orange,
          titleStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontSize: 50,
            letterSpacing: 4,
          ),
        ),
        loginProviders: <LoginProvider>[
          LoginProvider(
            // button: Buttons.google,
            animated: true,
            icon: FontAwesomeIcons.google,
            label: 'Google Account',
            callback: () async {
              final result = await _loginGoogle();
              if (result != null) {
                print(result);
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(LoginScreen.routeName);
              }
            },
          ),
        ]);
  }
}

// class GOOGLE_SIGNIN_BUTTON extends StatelessWidget {
//   const GOOGLE_SIGNIN_BUTTON({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//                           style: ElevatedButton.styleFrom(
//                               // backgroundColor: Colors.black87,
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(30)))),
//                           onPressed: () { },                          
//                           icon: Icon(FontsAwesomeIcons.google),
//                           label: Text(
//                                   'Add to Cart',
//                                   style: Styles.heading5,
//                                 ));
//   }
// }
