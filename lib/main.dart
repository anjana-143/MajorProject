import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protobuddy/auth/login.dart';
import 'package:protobuddy/auth/register.dart';
import 'package:protobuddy/database/firebase_options.dart';
import 'package:protobuddy/pages/buyandsale/buylist.dart';
import 'package:protobuddy/pages/buyandsale/postsell.dart';
import 'package:protobuddy/pages/homepage.dart';
import 'package:protobuddy/pages/portfolio/createportfolio.dart';
import 'package:protobuddy/pages/startpage.dart';
import 'package:protobuddy/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Protobuddy',
      theme: ThemeData(
        scaffoldBackgroundColor: black,
        appBarTheme: AppBarTheme(
          backgroundColor: black,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/homepage': (context) => const HomePage(),
        '/login': (context) => const UserLogin(),
        '/register': (context) => const UserRegister(),
        '/create': (context) => const CreatePortfolio(),
        '/buy': (context) => const BuyList(),
        '/sell': (context) => const PostSell(),
      },
    );
  }
}
