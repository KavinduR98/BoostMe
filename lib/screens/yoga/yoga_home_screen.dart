// ignore_for_file: file_names
import 'package:boostme/screens/yoga/yoga_add_screen.dart';
import 'package:boostme/utils/colors.dart';
import 'package:boostme/widgets/workout_list.dart';

import 'package:boostme/widgets/yoga_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class YogaHomeScreen extends StatelessWidget {
  const YogaHomeScreen({super.key});

  void navigateToWorkouts() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const YogaAddScreen()));
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          size: 30.0,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('yoga')
              .orderBy('date')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => YogaList(
                yogaSnap: snapshot.data!.docs[index].data(),
              ),
            );
          },
        ),
      ),
    );
  }
}
