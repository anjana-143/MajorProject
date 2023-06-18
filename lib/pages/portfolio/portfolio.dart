import 'package:flutter/material.dart';
import 'package:protobuddy/utils/constants.dart';

// ignore: must_be_immutable
class PortfolioDetail extends StatelessWidget {
  PortfolioDetail({
    super.key,
    required this.avatar,
    required this.description,
    required this.education,
    required this.email,
    required this.experience,
    required this.name,
    required this.speciality,
    required this.work,
    required this.title,
    required this.address,
  });

  late String avatar;
  late String name;
  late String email;
  late String speciality;
  late String experience;
  late String education;
  late String work;
  late String description;
  late String title;
  late String address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Portfolio',
          style: TextStyle(
            color: white,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(
          12,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  email,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  address,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  speciality,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage('$avatar'),
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    'Education: ',
                    style: TextStyle(
                      fontSize: 21,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    education,
                    style: TextStyle(
                      color: white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    'Experience: ',
                    style: TextStyle(
                      fontSize: 21,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    experience,
                    style: TextStyle(
                      color: white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Works',
                style: TextStyle(
                  fontSize: 21,
                  color: white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 19,
                  color: white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage('$work'),
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: TextStyle(
                  color: white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
