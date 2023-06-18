import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:protobuddy/database/firebase.dart';
import 'package:protobuddy/utils/constants.dart';
import 'package:protobuddy/widgets/textformfeild.dart';
import 'package:image_picker/image_picker.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  ImagePicker picker = ImagePicker();
  File? pickedImage;

  Future pickImage() async {
    try {
      XFile? pickedFile = (await ImagePicker().pickImage(
        source: ImageSource.gallery,
      ));
      setState(() {
        pickedImage = File(pickedFile!.path);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                        'Register!',
                        style: TextStyle(
                          color: white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 140,
                  icon: CircleAvatar(
                      radius: 70,
                      backgroundColor: white,
                      backgroundImage: pickedImage != null
                          ? FileImage(
                              pickedImage as File,
                            )
                          : null,
                      child: pickedImage != null
                          ? null
                          : const Text(
                              'Select \n Profile \n Picture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                  onPressed: () {
                    pickImage();
                  },
                ),
                customFormFeild(
                  controller: name,
                  hintText: 'Full Name',
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
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
                    userRegister(
                      name: name.text,
                      email: email.text,
                      password: password.text,
                      avatar: pickedImage,
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
    );
  }
}
