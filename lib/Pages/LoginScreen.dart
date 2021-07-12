import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:network_http/Pages/Homepage.dart';
import 'package:network_http/Provider/Admin.dart';
import 'package:network_http/Pages/signupSceen.dart';
import 'package:network_http/Provider/Mode.dart';
import 'package:provider/provider.dart';
import '../Widgets/CustomTextField.dart';
import 'Admin.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static final route = 'LoginScreen';
  final GlobalKey<FormState> keyFormLogin = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> keyScffold = GlobalKey<ScaffoldState>();
  String email, password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<AdmainProvder>(context);
    final modal = Provider.of<ModalHub>(context);
    double hiegtScreen = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: modal.load,
      child: Scaffold(
        key: keyScffold,
        backgroundColor: Colors.yellow[400],
        body: Form(
          key: keyFormLogin,
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.blue, size: 70),
                    Positioned(
                      bottom: 0,
                      child: Text(
                        'Buy It',
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 30),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: hiegtScreen * .1,
            ),
            CustomTextField(
              hintText: 'Enter Your email',
              iconText: Icons.email,
              onClick: (e) {
                email = e;
              },
            ),
            SizedBox(
              height: hiegtScreen * .02,
            ),
            CustomTextField(
              hintText: 'Enter Your Password',
              iconText: Icons.lock,
              onClick: (p) {
                password = p;
              },
            ),
            SizedBox(
              height: hiegtScreen * .1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.black,
                child: Text(
                  'Log in',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  loginFunction(context);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account?",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  child: Text('Sign Up'),
                  onTap: () {
                    Navigator.of(context).pushNamed(SignUpScreen.route);
                  },
                ),
              ],
            ),
            SizedBox(
              height: hiegtScreen * .1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Text(
                    "I'm Admin",
                    style: TextStyle(
                      fontSize: 20,
                      color: isAdmin.isAdmin ? Colors.yellow[400] : Colors.red,
                    ),
                  ),
                  onTap: () {
                    isAdmin.isAdmainFunfction(true);
                  },
                ),
                GestureDetector(
                  child: Text(
                    "I'm User",
                    style: TextStyle(
                      fontSize: 20,
                      color: isAdmin.isAdmin ? Colors.red : Colors.yellow[400],
                    ),
                  ),
                  onTap: () {
                    isAdmin.isAdmainFunfction(false);
                  },
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  loginFunction(BuildContext context) async {
    final isAdmin = Provider.of<AdmainProvder>(context, listen: false);
    final modal = Provider.of<ModalHub>(context, listen: false);
    modal.isloading(true);
    if (keyFormLogin.currentState.validate()) {
      keyFormLogin.currentState.save();
      if (isAdmin.isAdmin) {
        if (password == 'admin1234') {
          try {
            await auth.signInWithEmailAndPassword(
                email: email, password: password);
            Navigator.of(context).pushNamed(AdminPage.route);
          } catch (e) {
            modal.isloading(false);
            keyScffold.currentState
                .showSnackBar(SnackBar(content: Text(e.massage)));
          }
        } else {
          // modal.isloading(false);
          keyScffold.currentState
              .showSnackBar(SnackBar(content: Text('Password wrong')));
        }
      } else {
        print('User');

        /// is User
        try {
          auth.signInWithEmailAndPassword(email: email, password: password);
          //     .then((value) {
          //   //  print("signInWithEmailAndPassword${value}");
          // });
          // Navigator.of(context).pushNamed(HomePage.route);
        } catch (e) {
          // modal.isloading(false);
          // keyScffold.currentState
          //     .showSnackBar(SnackBar(content: Text(e.massage.toString())));
        }
      }
    }
    //modal.isloading(false);
  }
}
