// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:boostme/providers/user_provider.dart';
import 'package:boostme/resources/firestore_methods.dart';
import 'package:boostme/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:boostme/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YogaAddScreen extends StatefulWidget {
  const YogaAddScreen({Key? key}) : super(key: key);

  @override
  _YogaAddScreenState createState() => _YogaAddScreenState();
}

class _YogaAddScreenState extends State<YogaAddScreen> {
  bool isLoading = false;

  final TextEditingController _yDateController = TextEditingController();
  final TextEditingController _yTypeController = TextEditingController();
  final TextEditingController _yDurationController = TextEditingController();
  final TextEditingController _yInstructorController = TextEditingController();
  final TextEditingController _yNoteController = TextEditingController();

  void saveYoga(String uid) async {
    // start the loading
    try {
      // save data to the db
      String res = await FireStoreMethods().saveYoga(
          uid,
          _yDateController.text,
          _yTypeController.text,
          _yDurationController.text,
          _yInstructorController.text,
          _yNoteController.text);
      // Navigate to workout home scrren
      Navigator.pop(context);

      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          context,
          'Inserted Yoga Successfully !!!!',
        );
      } else {
        //
      }
    } catch (err) {
      //
    }
  }

  @override
  void dispose() {
    super.dispose();
    _yDateController.dispose();
    _yTypeController.dispose();
    _yInstructorController.dispose();
    _yDurationController.dispose();
    _yNoteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add a New Yoga Session',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _yDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Select Date"),
                  readOnly: true,
                  // set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        // DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        _yDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _yTypeController,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(label: Text('Enter Yoga Style ')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _yDurationController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(label: Text('Enter Duration')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _yInstructorController,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(label: Text('Enter Instructor')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _yNoteController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(label: Text('Enter Note')),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => saveYoga(
                    userProvider.getUser.uid,
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
