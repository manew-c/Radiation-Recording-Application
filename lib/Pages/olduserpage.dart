import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../map.dart';
import 'package:flutter_application_1/Pages/allvariable.dart';

class userpage extends StatefulWidget {
  const userpage({super.key});

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {
  final _formKey = GlobalKey<FormState>();
  final SERIES = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('เลือกผู้ใช้และหัววัด'),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'ขณะนี้คุณอยู่ที่ไซต์งาน${Point.worksite}จังหวัด${Point.province}'),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'ชื่อผู้บันทึก', icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value! == '') {
                          return 'Please enter your ชื่อผู้บันทึก';
                        }
                        return null;
                      },
                      onSaved: (value) => user.username = value!,
                      autofocus: true,
                      controller: SERIES,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'หัววัด', icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value! == '') {
                          return 'Please enter your หัววัด';
                        }
                        return null;
                      },
                      onSaved: (value) => user.detector = value!,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'รายละเอียดหัววัด', icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value! == '') {
                          return 'Please enter your รายละเอียดหัววัด';
                        }
                        return null;
                      },
                      onSaved: (value) => user.detectorinformation = value!,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                //อันนี้เพิ่มหลัก
                                CollectionReference siteandprovind =
                                    FirebaseFirestore.instance
                                        .collection('ไซต์งาน');
                                siteandprovind
                                    .doc(Point.worksite)
                                    .collection('ผู้วัดรังสี')
                                    .doc(user.username)
                                    .collection('หัววัด')
                                    .doc(user.detector)
                                    .set({
                                  'รายละเอียดหัววัด': user.detectorinformation
                                });
                                //อันนี้เพิ่มแยกส่วน
                                FirebaseFirestore.instance
                                    .collection("ชื่อคนall")
                                    .doc(user.username)
                                    .set({});
                                FirebaseFirestore.instance
                                    .collection("หัววัดall")
                                    .doc(user.detector)
                                    .set({
                                  'รายละเอียดหัววัด': user.detectorinformation
                                });

                                _formKey.currentState!.reset();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MapsPage()));
                              }
                            },
                            child: const Text('บันทึก'),
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }
}

/*class _userclass {
  String username;
  String detector;
  String detectorinformation;
  _userclass(
      {required this.username,
      required this.detector,
      required this.detectorinformation});
}

_userclass user =
    _userclass(username: '', detector: '', detectorinformation: '');*/
