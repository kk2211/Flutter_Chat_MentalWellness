import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/RoundedButton.dart';

import 'chat_screen.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
var User_Score = Map();

int sum = 0;

class Survey extends StatefulWidget {
  static const String id = "survey_screen";
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrenUser();
    sum = 0;
  }

  void getCurrenUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 0, left: 10, right: 30),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "For Each of the following Questions,Give a score between 1-5:\n"
                  "1 being Very Poor\n"
                  "5 being Very Good\n",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "How would you rate  your current stress level?",
                  style: kSurveyTextStyle,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: " 0-5"),
                  onChanged: (text) {
                    print(text);
                    sum = sum + int.parse(text);
                  },
                ),
                SizedBox(height: 30),
                Text(
                  "How would you rate your current overall well-being?",
                  style: kSurveyTextStyle,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: " 0-5"),
                  onChanged: (text) {
                    print(text);
                    sum = sum + int.parse(text);
                  },
                ),
                SizedBox(height: 30),
                Text(
                  "Are you feeling comfortable currently to talk about your mental health?",
                  style: kSurveyTextStyle,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: " 0-5"),
                  onChanged: (text) {
                    print(text);
                    sum = sum + int.parse(text);
                  },
                ),
                SizedBox(height: 30),
                Text(
                  "How optimistic are you feeling currently?",
                  style: kSurveyTextStyle,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: " 0-5"),
                  onChanged: (text) {
                    print(text);
                    sum = sum + int.parse(text);
                    User_Score[loggedInUser.email] = sum;
                    print(User_Score);
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: RoundedButton(
                    tittle: "login",
                    colour: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.pushNamed(context, ChatScreen.id);
                    },
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
