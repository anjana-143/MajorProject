import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protobuddy/database/firebase.dart';
import 'package:protobuddy/pages/buyandsale/viewwork.dart';
import 'package:protobuddy/utils/constants.dart';

class BuyList extends StatelessWidget {
  const BuyList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All for Sale"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: StreamBuilder(
            stream: firestore.collection("protobuddy/data/forSell").snapshots(),
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
                      Get.to(() => ViewWork(
                            work: '${data['work']}',
                            email: '${data['email']}',
                          ));
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
                                  'Title: ${data['title']}',
                                  style: TextStyle(
                                    fontSize: 19,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: white,
        onPressed: () {
          Get.toNamed('/sell');
        },
        child: Icon(
          Icons.add,
          color: black,
        ),
      ),
    );
  }
}
