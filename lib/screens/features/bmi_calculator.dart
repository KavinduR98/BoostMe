import 'package:boostme/responsive/mobile_screen_layout.dart';
import 'package:boostme/utils/colors.dart';
import 'package:boostme/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BMICal extends StatefulWidget {
  final String uid;
  const BMICal({super.key, required this.uid});

  @override
  State<BMICal> createState() => _BMICalState();
}

class _BMICalState extends State<BMICal> {
  double _height = 170.0;
  double _weight = 70.0;
  int _bmi = 0;
  String _condition = 'Select Data';

  var userData = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Row(
          children: [
            Text(
              userData['username'],
            ),
            const Text('`s BMI')
          ],
        ),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MobileScreenLayout(),
              ),
            );
          },
          color: Colors.white, // <-- SEE HERE
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.35,
              width: double.infinity,
              decoration: const BoxDecoration(color: mobileBackgroundColor),
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "BMI",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50.0,
                            ),
                          ),
                          Text(
                            "Calculator",
                            style:
                                TextStyle(color: Colors.white, fontSize: 40.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 125.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(
                            userData['photoUrl'],
                          ),
                          radius: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "BMI Value : ",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 30.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: "$_bmi",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Condition : ",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 25.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: "$_condition",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: secondaryColor),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  const Text(
                    "Choose Data",
                    style: TextStyle(
                        color: blueColor,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Height :",
                      style:
                          const TextStyle(color: primaryColor, fontSize: 25.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: " $_height cm",
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Slider(
                    value: _height,
                    min: 0,
                    max: 250,
                    onChanged: (height) {
                      setState(() {
                        _height = height;
                      });
                    },
                    divisions: 250,
                    label: "$_height",
                    activeColor: blueColor,
                    inactiveColor: primaryColor,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Weight :",
                      style:
                          const TextStyle(color: primaryColor, fontSize: 25.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: " $_weight kg",
                          style: const TextStyle(
                              color: secondaryColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Slider(
                    value: _weight,
                    min: 0,
                    max: 250,
                    onChanged: (weight) {
                      setState(() {
                        _weight = weight;
                      });
                    },
                    divisions: 300,
                    label: "$_weight",
                    activeColor: blueColor,
                    inactiveColor: primaryColor,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Column(children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //18.5-25 = Healthy, 25-30 = Overweight, >30 = Obesity
                                _bmi = (_weight /
                                        ((_height / 100) * (_height / 100)))
                                    .round()
                                    .toInt();
                                if (_bmi >= 18.5 && _bmi <= 25) {
                                  _condition = "Normal";
                                } else if (_bmi > 25 && _bmi <= 30) {
                                  _condition = "Overweight";
                                } else if (_bmi > 30) {
                                  _condition = "Obesity";
                                } else {
                                  _condition = "Underweight";
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: blueColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 110),
                            ),
                            child: const Text(
                              "Calculate",
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ])),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
