import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:protobuddy/database/firebase.dart';
import 'package:protobuddy/utils/constants.dart';
import 'package:protobuddy/widgets/textformfeild.dart';

class CreatePortfolio extends StatefulWidget {
  const CreatePortfolio({super.key});

  @override
  State<CreatePortfolio> createState() => _CreatePortfolioState();
}

class _CreatePortfolioState extends State<CreatePortfolio> {
  ImagePicker picker = ImagePicker();

  File? pickedImage;
  File? pickedWork;

  Future pickProfile() async {
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

  Future pickWork() async {
    try {
      XFile? pickedFile = (await ImagePicker().pickImage(
        source: ImageSource.gallery,
      ));
      setState(() {
        pickedWork = File(pickedFile!.path);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController speciality = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController education = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Portfolio',
          style: TextStyle(
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(12),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                              'Select \n User \n Picture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                  onPressed: () {
                    pickProfile();
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
                  controller: address,
                  hintText: 'Address',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                customFormFeild(
                  controller: speciality,
                  hintText: 'Speciality',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                customFormFeild(
                  controller: experience,
                  hintText: 'Experience',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                customFormFeild(
                  controller: education,
                  hintText: 'Education',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                customFormFeild(
                  controller: title,
                  hintText: 'Work Title',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                GestureDetector(
                  onTap: () {
                    pickWork();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    decoration: BoxDecoration(
                      image: pickedWork != null
                          ? DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: FileImage(
                                pickedWork as File,
                              ),
                            )
                          : null,
                      color: red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: (pickedWork == null)
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Choose a Work',
                                  style: TextStyle(
                                    color: black.withOpacity(0.5),
                                  ),
                                ),
                                Icon(
                                  LineIcons.fileUpload,
                                ),
                              ],
                            ),
                          )
                        : AspectRatio(
                            aspectRatio: 16 / 9,
                          ),
                  ),
                ),
                customFormFeild(
                  controller: description,
                  hintText: 'Description',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                MaterialButton(
                  onPressed: () {
                    createPortfolio(
                      name: name.text,
                      email: email.text,
                      speciality: speciality.text,
                      experience: experience.text,
                      education: education.text,
                      description: description.text,
                      profile: pickedImage,
                      work: pickedWork,
                      address: address.text,
                      title: title.text,
                    );
                  },
                  color: grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Create Portfolio',
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
