import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:protobuddy/models/portfolioModel.dart';
import 'package:protobuddy/models/sellModel.dart';
import 'package:protobuddy/models/usermodel.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

//Login

Future userLogin({
  required email,
  required password,
}) async {
  try {
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Get.toNamed('/homepage');
    });
  } catch (e) {}
}
//Register

Future userRegister({
  required name,
  required email,
  required password,
  required avatar,
}) async {
  await auth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value) async {
    var uploaded =
        await storage.ref('useravatar').child(value.user!.uid).putFile(avatar);

    var avatarLink = await uploaded.ref.getDownloadURL();
    UserModel currentUser = UserModel();
    currentUser.fullname = name;
    currentUser.email = email;
    currentUser.avatar = avatarLink;
    currentUser.user = 'user';
    currentUser.uid = value.user!.uid;

    await firestore
        .collection('protobuddy')
        .doc(value.user!.uid)
        .set(
          currentUser.toMap(),
        )
        .then((value) {
      Get.toNamed('/homepage');
    });
  });
}

// Check Auth

checkAuth() {
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      Get.toNamed('/login');
    } else {
      Get.toNamed('/homepage');
    }
  });
}

//Create portfolio

Future createPortfolio({
  required name,
  required email,
  required speciality,
  required experience,
  required education,
  required description,
  required profile,
  required work,
  required title,
  required address,
}) async {
  var uploaded = await storage
      .ref('portfolioAvatar')
      .child('$email$name')
      .putFile(profile);

  var avatarLink = await uploaded.ref.getDownloadURL();

  var uploadedWork =
      await storage.ref('portfolioWork').child('$email$name').putFile(work);

  var workLink = await uploadedWork.ref.getDownloadURL();

  PortfolioModel portfolioModel = PortfolioModel();

  portfolioModel.avatar = avatarLink;
  portfolioModel.work = workLink;
  portfolioModel.name = name;
  portfolioModel.email = email;
  portfolioModel.speciality = speciality;
  portfolioModel.experience = experience;
  portfolioModel.education = education;
  portfolioModel.description = description;
  portfolioModel.title = title;
  portfolioModel.address = address;

  await firestore
      .collection('protobuddy')
      .doc('data')
      .collection('portfolio')
      .doc()
      .set(
        portfolioModel.toMap(),
      )
      .then((value) {
    Get.toNamed('/homepage');
  }).catchError((error) {
    print("Failed to add portfolio: $error");
  });
}

//Sell Works

Future sellWorks({
  required title,
  required category,
  required description,
  required work,
}) async {
  var uploadedWork = await storage
      .ref('forSell')
      .child('${auth.currentUser!.uid}' + '_' + '$title')
      .putFile(work);

  var workLink = await uploadedWork.ref.getDownloadURL();

  SellModel sellModel = SellModel();

  sellModel.uid = auth.currentUser!.uid;
  sellModel.work = workLink;
  sellModel.title = title;
  sellModel.category = category;
  sellModel.description = description;
  sellModel.email = auth.currentUser!.email;

  await firestore
      .collection('protobuddy')
      .doc('data')
      .collection('forSell')
      .doc()
      .set(
        sellModel.toMap(),
      )
      .then((value) {
    Get.toNamed('/buy');
  }).catchError((error) {
    print("Failed to post: $error");
  });
}
