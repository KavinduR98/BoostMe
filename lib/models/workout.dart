// ignore_for_file: equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String exerciseName;
  final String uid;
  final String exId;
  final String exWeight;
  final String exReps;
  final String exSets;
  final String exDate;

  const Workout({
    required this.exerciseName,
    required this.uid,
    required this.exId,
    required this.exWeight,
    required this.exReps,
    required this.exSets,
    required this.exDate,
  });

  static Workout fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Workout(
      uid: snapshot["uid"],
      exerciseName: snapshot["name"],
      exId: snapshot["exid"],
      exWeight: snapshot['weight'],
      exReps: snapshot['reps'],
      exSets: snapshot['sets'],
      exDate: snapshot['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "exid": exId,
        'name': exerciseName,
        "exid": exId,
        'weight': exWeight,
        'reps': exReps,
        'sets': exSets,
        'date': exDate,
      };
}
