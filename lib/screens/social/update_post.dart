import 'package:boostme/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostUpdate extends StatefulWidget {
  const PostUpdate({super.key});

  @override
  State<PostUpdate> createState() => _PostUpdateState();
}

class _PostUpdateState extends State<PostUpdate> {
  final CollectionReference post =
      FirebaseFirestore.instance.collection('workout');

  bool isLoading = false;

  final TextEditingController _exNameController = TextEditingController();
  final TextEditingController _exWeightController = TextEditingController();
  final TextEditingController _exRepsController = TextEditingController();
  final TextEditingController _exSetsController = TextEditingController();
  final TextEditingController _exDateController = TextEditingController();

  void updateExercise(docId) {
    final data = {
      'name': _exNameController.text,
      'weight': _exWeightController.text,
      'reps': _exRepsController.text,
      'sets': _exSetsController.text,
      'date': _exDateController.text,
    };
    post.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    _exNameController.text = args['name'];
    _exWeightController.text = args['weight'];
    _exRepsController.text = args['reps'];
    _exSetsController.text = args['sets'];
    _exDateController.text = args['date'];
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
          'Update Exercise',
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
                  controller: _exNameController,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(label: Text('Exercise Name')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _exWeightController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Weight')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _exRepsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Reps Count')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _exSetsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Sets Count')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _exDateController,
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
                        _exDateController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
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
