import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protobuddy/database/firebase.dart';
import 'package:protobuddy/utils/constants.dart';
import 'package:protobuddy/widgets/textformfeild.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(12),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Login!',
                        style: TextStyle(
                          color: white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                customFormFeild(
                  controller: email,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                customFormFeild(
                  controller: password,
                  hintText: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                MaterialButton(
                  onPressed: () {
                    userLogin(
                      email: email.text,
                      password: password.text,
                    );
                  },
                  color: grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: black,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              color: white,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed('/register');
            },
            child: Text("Register!"),
          ),
        ],
      ),
    );
  }
}
