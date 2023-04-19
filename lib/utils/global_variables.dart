import 'package:boostme/screens/social/add_post.dart';
import 'package:boostme/screens/social/feed_screen.dart';
import 'package:boostme/screens/social/search_screen.dart';
import 'package:boostme/screens/user/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/workout/workout _home_screen.dart';
import '../screens/yoga/yoga_home_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const WorkoutHome(),
  const YogaHomeScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
