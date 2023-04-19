import 'dart:typed_data';
import 'package:boostme/models/post.dart';
import 'package:boostme/models/workout.dart';
import 'package:boostme/models/yoga.dart';
import 'package:boostme/resources/storage_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Add a new exercise
  Future<String> addExercise(
    String uid,
    String exerciseName,
    String exWeight,
    String exReps,
    String exSets,
    String exDate,
  ) async {
    String res = 'Some error occured';
    try {
      String exId = const Uuid().v1();
      Workout workout = Workout(
        uid: uid,
        exerciseName: exerciseName,
        exWeight: exWeight,
        exReps: exReps,
        exSets: exSets,
        exDate: exDate,
        exId: exId,
      );
      _firestore.collection('workout').doc(exId).set(
            workout.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Add a new Yoga
  Future<String> saveYoga(
    String uid,
    String yDate,
    String yType,
    String yDuration,
    String yInstructor,
    String yNote,
  ) async {
    String res = 'Some error occured';
    try {
      String yogaId = const Uuid().v1();
      Yoga workout = Yoga(
        uid: uid,
        yogaDate: yDate,
        yogaType: yType,
        yogaDuration: yDuration,
        yogaInstructor: yInstructor,
        yogaNote: yNote,
        yId: yogaId,
      );
      _firestore.collection('yoga').doc(yogaId).set(
            workout.toJson(),
          );
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String post) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(post).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Exercise
  Future<String> deleteExercise(String exId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('workout').doc(exId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Yoga Info
  Future<String> deleteYogaInfo(String yId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('yoga').doc(yId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
