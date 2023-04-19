// ignore_for_file: equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';

class Yoga {
  final String yogaDate;
  final String yogaType;
  final String yogaDuration;
  final String yogaInstructor;
  final String yogaNote;
  final String uid;
  final String yId;

  const Yoga({
    required this.yogaDate,
    required this.yogaType,
    required this.yogaDuration,
    required this.yogaInstructor,
    required this.yogaNote,
    required this.uid,
    required this.yId,
  });

  static Yoga fromSnap(DocumentSnapshot yogaSnap) {
    var snapshot = yogaSnap.data() as Map<String, dynamic>;

    return Yoga(
      yogaType: snapshot["type"],
      yogaDate: snapshot["date"],
      yogaDuration: snapshot["duration"],
      yogaInstructor: snapshot['instructor'],
      yogaNote: snapshot["note"],
      uid: snapshot["uid"],
      yId: snapshot["yId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": yogaType,
        "date": yogaDate,
        'duration': yogaDuration,
        "instructor": yogaInstructor,
        'note': yogaNote,
        'uid': uid,
        'yId': yId,
      };
}
