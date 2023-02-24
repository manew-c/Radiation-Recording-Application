import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

class savedetectorPage extends StatefulWidget {
  const savedetectorPage({super.key});

  @override
  State<savedetectorPage> createState() => _savedetectorPageState();
}

class _savedetectorPageState extends State<savedetectorPage> {
  final _formKey = GlobalKey<FormState>();
  final SERIES = TextEditingController();
  String? savedetectorname;
  String? savedetectortype;
  double? saveconvertionfactor;
  String? savenote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('บันทึกข้อมูลหัววัดรังสี'),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'ชื่อหัววัด', icon: Icon(Icons.key)),
                      validator: (value1) {
                        if (value1!.isEmpty) {
                          return 'Please enter your หัววัด';
                        }
                        return null;
                      },
                      onSaved: (value1) => savedetectorname = value1!,
                      //controller: SERIES,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'ประเภทหัววัด', icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your ประเภทหัววัด';
                        }
                        return null;
                      },
                      onSaved: (value) => savedetectortype = value!,
                      //controller: SERIES,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'ค่าconversion factor',
                          icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter conversion factor';
                        } else if (isFloat(value) == false) {
                          return 'ค่าที่กรอกไม่ใช่ตัวเลข';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          saveconvertionfactor = double.parse(value!),
                      //controller: SERIES,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'รายละเอียดอื่นๆ', icon: Icon(Icons.key)),
                      validator: (value3) {
                        if (value3!.isEmpty) {
                          return 'หากไม่มีโปรดใส่เครื่องหมาย - ';
                        }
                        return null;
                      },
                      onSaved: (value3) => savenote = value3!,
                      //autofocus: true,
                      //controller: SERIES,
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

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'บันทึกหัววัด  $savedetectorname  เรียบร้อย'),
                                  duration: const Duration(seconds: 10),
                                ));

                                FirebaseFirestore.instance
                                    .collection("หัววัดall")
                                    .doc(savedetectorname)
                                    .set({
                                  'type': savedetectortype,
                                  'conversionfactor': saveconvertionfactor,
                                  'note': savenote
                                });
                                _formKey.currentState!.reset();
                              }
                            }, //อย่าลืมเปลี่ยนpageกลับมาเหมือนเดิมนาจาาา
                            child: const Text('บันทึก'),
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
