import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_http/Provider/Mode.dart';
import 'package:provider/provider.dart';
import '../Widgets/CustomTextField.dart';
//import 'Autho.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  static final route = 'SignUpScreen';
  String email, password;
  // final auto = Auth();
  final FirebaseAuth autor = FirebaseAuth.instance;
  final GlobalKey<FormState> keForm = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> keyScfolld = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double hiegtScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      key: keyScfolld,
      backgroundColor: Colors.yellow[400],
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHub>(context).load,
        child: Form(
          key: keForm,
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
              hintText: 'Enter Your Name',
              iconText: Icons.perm_identity,
              onClick: (name) {},
            ),
            SizedBox(
              height: hiegtScreen * .02,
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // ignore: deprecated_member_use
              child:
                  // Builder( builder: (context){return
                  // ignore: deprecated_member_use
                  FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.black,
                      child: Text(
                        'Sign Up ',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      onPressed: () async {
                        final mode =
                            Provider.of<ModalHub>(context, listen: false);

                        //keForm.currentState.validate();
                        keForm.currentState.save();
                        mode.isloading(true);
                        try {
                          //var result = await auto.signup(email, password);
                          var result =
                              await autor.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          mode.isloading(false);
                        } on PlatformException catch (e) {
                          print(e.toString());
                          mode.isloading(false);
                          keyScfolld.currentState
                              .showSnackBar(SnackBar(content: Text(e.message)));
                        }
                        mode.isloading(false);
                      }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You have account ",
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  child: Text('Log In'),
                  onTap: () {},
                ),
                // Hero(tag: 'logo', child: Text('Hero Test'))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
