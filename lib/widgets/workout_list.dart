import 'package:boostme/providers/user_provider.dart';
import 'package:boostme/resources/firestore_methods.dart';
import 'package:boostme/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boostme/models/user.dart' as model;
import '../screens/workout/workout_update_screen.dart';
import '../utils/utils.dart';

class WorkoutList extends StatefulWidget {
  final snap;
  const WorkoutList({
    super.key,
    required this.snap,
  });

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  deleteExercise(String exId) async {
    try {
      await FireStoreMethods().deleteExercise(exId);
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
                  "${widget.snap['date']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
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
                          "Exercise Name : ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.snap['name']}",
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
                          "Total Weight : ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.snap['weight']}Kg",
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
                          "Sets Count : ",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.snap['sets']}",
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
                          "Reps Count : ",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.snap['reps']}",
                          style: const TextStyle(fontSize: 20.0),
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
            height: 160.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                //   color: Color.fromARGB(0, 199, 9, 132),
                boxShadow: const [
                  BoxShadow(
                    color: secondaryColor,
                    offset: Offset(0.1, 9.0),
                  )
                ]),
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
                          widget.snap['date'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          widget.snap['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text("${widget.snap['weight']}kg"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Chip(
                        label: Text("${widget.snap['sets']}sets"),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Chip(
                        label: Text("${widget.snap['reps']}reps"),
                      ),
                      const SizedBox(width: 60.0),
                      Row(
                        children: [
                          CupertinoButton(
                            minSize: double.minPositive,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WorkoutUpdate(),
                                  settings: RouteSettings(
                                    arguments: {
                                      'name': widget.snap['name'],
                                      'weight': widget.snap['weight'],
                                      'reps': widget.snap['reps'],
                                      'sets': widget.snap['sets'],
                                      'date': widget.snap['date'],
                                      'id': widget.snap['exid'],
                                    },
                                  ),
                                ),
                              );
                            },
                            color: Colors.greenAccent.withOpacity(0.9),
                            child: const Icon(Icons.edit_attributes_rounded,
                                size: 30),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CupertinoButton(
                        minSize: double.minPositive,
                        padding: EdgeInsets.zero,
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
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );

                          if (result == null || !result) {
                            return;
                          }
                          deleteExercise(
                            widget.snap['exid'].toString(),
                          );
                        },
                        color: Colors.redAccent.withOpacity(0.9),
                        child: const Icon(Icons.delete, size: 30),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
