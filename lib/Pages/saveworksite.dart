import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class saveworksitePage extends StatefulWidget {
  const saveworksitePage({super.key});

  @override
  State<saveworksitePage> createState() => _saveworksitePageState();
}

class _saveworksitePageState extends State<saveworksitePage> {
  final _formKey = GlobalKey<FormState>();
  final SERIES = TextEditingController();
  String? saveworksite;
  String? saveprovince;
  String? savenote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('บันทึกข้อมูลไซต์งาน'),
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
                          labelText: 'ไซต์งาน', icon: Icon(Icons.key)),
                      validator: (value1) {
                        if (value1!.isEmpty) {
                          return 'Please enter your ไซต์งาน';
                        }
                        return null;
                      },
                      onSaved: (value1) => saveworksite = value1!,
                      //controller: SERIES,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'จังหวัด', icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your จังหวัด';
                        }
                        return null;
                      },
                      onSaved: (value) => saveprovince = value!,
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
                                      'บันทึกไซต์งาน  $saveworksite จังหวัด$saveprovince  และรายละเอียด เรียบร้อย'),
                                  duration: const Duration(seconds: 10),
                                ));

                                FirebaseFirestore.instance
                                    .collection("allworksite")
                                    .doc(saveworksite)
                                    .set({
                                  'จังหวัด': saveprovince,
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
