import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protobuddy/components/profile.dart';
import 'package:protobuddy/database/firebase.dart';
import 'package:protobuddy/models/usermodel.dart';
import 'package:protobuddy/pages/portfolio/portfolio.dart';
import 'package:protobuddy/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel currentUser = UserModel();
  @override
  void initState() {
    super.initState();
    firestore
        .collection("protobuddy")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      currentUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: black,
        child: UserProfile(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Portfolio's"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: StreamBuilder(
            stream:
                firestore.collection("protobuddy/data/portfolio").snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return const Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: black,
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot data = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => PortfolioDetail(
                          avatar: data['avatar'],
                          description: data['description'],
                          education: data['education'],
                          email: data['email'],
                          experience: data['experience'],
                          name: data['name'],
                          speciality: data['speciality'],
                          work: data['work'],
                          address: data['address'],
                          title: data['title'],
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            opacity: 0.3,
                            fit: BoxFit.fill,
                            image: NetworkImage('${data['work']}'),
                          ),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data['name']}',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${data['title']}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text('Description: ${data['description']}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
