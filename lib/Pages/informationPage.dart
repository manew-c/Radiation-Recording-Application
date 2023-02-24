import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/olduserpage.dart';
import 'package:flutter_application_1/Pages/allvariable.dart';

class informationPage extends StatefulWidget {
  const informationPage({super.key});

  @override
  State<informationPage> createState() => _informationPageState();
}

class _informationPageState extends State<informationPage> {
  final _formKey = GlobalKey<FormState>();
  final SERIES = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ข้อมูลPROJECT'),
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
                      validator: (value) {
                        if (value! == '') {
                          return 'Please enter your ไซต์งาน';
                        }
                        return null;
                      },
                      onSaved: (value) => Point.worksite = value!,
                      autofocus: true,
                      controller: SERIES,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'จังหวัด', icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value! == '') {
                          return 'Please enter your จังหวัด';
                        }
                        return null;
                      },
                      onSaved: (value) => Point.province = value!,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          labelText: 'รายละเอียดเพิ่มเติม',
                          icon: Icon(Icons.key)),
                      validator: (value) {
                        if (value! == '') {
                          return 'เช่น อำเภอ เขต เมือง เป็นต้น';
                        }
                        return null;
                      },
                      onSaved: (value) => Point.worksitenote = value!,
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
                                //อันนี้เพิ่มในไซต์งาน
                                CollectionReference siteandprovind =
                                    FirebaseFirestore.instance
                                        .collection('ไซต์งาน');
                                siteandprovind.doc(Point.worksite).set({
                                  'จังหวัด': Point.province,
                                  'note': Point.worksitenote
                                });
                                //อันนี้เพิ่มในแยกส่วน
                                FirebaseFirestore.instance
                                    .collection("allworksite")
                                    .doc(Point.worksite)
                                    .set({
                                  'จังหวัด': Point.province,
                                  'note': Point.worksitenote
                                });
                                _formKey.currentState!.reset();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const userpage()));
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

/*class _pointclass {
  String worksite;
  double number;
  String province;
  _pointclass(
      {required this.worksite, required this.number, required this.province});
}

_pointclass Point = _pointclass(worksite: '', number: 0, province: '');*/
