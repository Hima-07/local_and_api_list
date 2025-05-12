import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ui_managnment/add_item_to_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState(){
    super.initState();
  }

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
                Expanded(child: ElevatedButton(onPressed: () async {
                  await signInWithGoogle();
                  if(userCredential != null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddItemToList()));
                  }
                }, child: Text('Continue With Google'))),
              ],
            ),
          ),
        ],
      ),
    );
  }


  UserCredential? userCredential;
  Future<UserCredential?> signInWithGoogle() async {
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '618222452701-d811uf57dgq8visjvpr54063ahbcsg9c.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      // Once signed in, return the UserCredential
      return userCredential;
    }catch(e){
      print('Error $e');
    }
    return null;
  }
}