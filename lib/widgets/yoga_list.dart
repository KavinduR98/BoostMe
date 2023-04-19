// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:boostme/providers/user_provider.dart';
import 'package:boostme/resources/firestore_methods.dart';
import 'package:boostme/screens/yoga/yoga_update_screen.dart';

import 'package:boostme/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boostme/models/user.dart' as model;
import '../utils/utils.dart';

class YogaList extends StatefulWidget {
  final yogaSnap;
  const YogaList({
    super.key,
    required this.yogaSnap,
  });

  @override
  State<YogaList> createState() => _YogaListState();
}

class _YogaListState extends State<YogaList> {
  deleteYogaInfo(String yId) async {
    try {
      await FireStoreMethods().deleteYogaInfo(yId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      color: mobileBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  "${widget.yogaSnap['date']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Yoga Type : ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.yogaSnap['type']}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Duration Time : ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.yogaSnap['duration']}mins",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Instructor : ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.yogaSnap['instructor']}",
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // ignore: prefer_const_constructors
                        Text(
                          "Note : ",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.yogaSnap['note']}",
                          style: const TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Container(
                      color: Colors.cyan,
                      padding: const EdgeInsets.all(14),
                      child: const Text(
                        "okay",
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 255, 255, 255),
                    blurRadius: 1.0,
                    spreadRadius: 2.5,
                  )
                ]),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.yogaSnap['date'],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.yogaSnap['type'],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Chip(
                          label: Text("${widget.yogaSnap['duration']}mins"),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Chip(
                          label: Text("${widget.yogaSnap['instructor']}"),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const SizedBox(width: 40.0),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const YogaUpdateScreen(),
                                settings: RouteSettings(
                                  arguments: {
                                    'date': widget.yogaSnap['date'],
                                    'type': widget.yogaSnap['type'],
                                    'duration': widget.yogaSnap['duration'],
                                    'instructor': widget.yogaSnap['instructor'],
                                    'note': widget.yogaSnap['note'],
                                    'id': widget.yogaSnap['yId'],
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_note_rounded),
                          iconSize: 40.0,
                          color: Colors.black,
                        ),
                        IconButton(
                          onPressed: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    'This action will permanently delete this data'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );

                            if (result == null || !result) {
                              return;
                            }
                            deleteYogaInfo(
                              widget.yogaSnap['yId'].toString(),
                            );
                          },
                          icon: const Icon(Icons.delete),
                          iconSize: 20.0,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
