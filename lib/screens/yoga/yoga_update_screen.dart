import 'package:boostme/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YogaUpdateScreen extends StatefulWidget {
  const YogaUpdateScreen({super.key});

  @override
  State<YogaUpdateScreen> createState() => _YogaUpdateScreenState();
}

class _YogaUpdateScreenState extends State<YogaUpdateScreen> {
  final CollectionReference workout =
      FirebaseFirestore.instance.collection('yoga');

  bool isLoading = false;

  final TextEditingController _yDateController = TextEditingController();
  final TextEditingController _yTypeController = TextEditingController();
  final TextEditingController _yDurationController = TextEditingController();
  final TextEditingController _yInstructorController = TextEditingController();
  final TextEditingController _yNoteController = TextEditingController();

  void updateExercise(docId) {
    final data = {
      'date': _yDateController.text,
      'type': _yTypeController.text,
      'duration': _yDurationController.text,
      'instructor': _yInstructorController.text,
      'note': _yNoteController.text,
    };
    workout.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    _yDateController.text = args['date'];
    _yTypeController.text = args['type'];
    _yDurationController.text = args['duration'];
    _yInstructorController.text = args['instructor'];
    _yNoteController.text = args['note'];
    final docId = args['id'];

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
          'Update Yoga Info',
        ),
      ),
      // Add FORM
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
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Select Date" //label text of field
                      ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
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
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(label: Text('Enter Instructor')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _yNoteController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Enter Note')),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    updateExercise(docId);
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.cyan),
                  ),
                  child: const Text(
                    'Update',
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
