import 'package:flutter/material.dart';
import 'package:ui_managnment/add_item_to_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    controller: email,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                    controller: password,
                    obscureText: true,
                )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemToList()));
                }, child: Text('Log In'))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemToList()));
                }, child: Text('Continue With Google'))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }
}

class UserCredential {
  String? uid;
  String? email;
  String? password;
  String? displayName;
}