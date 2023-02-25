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
  String? saveprovince = '';
  String? savenote;
  final _listprovince = <String>[
    'กรุงเทพมหานคร',
    'กระบี่',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พะเยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'หนองบัวลำภู',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'อ้างทอง',
    'อำนาจเจริญ',
    'อุดรธานี',
    'อุตรดิตถ์',
    'อุทัยธานี',
    'อุบลราชธานี'
  ];

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
                    const SizedBox(height: 10),
                    //เลือกจังหวัดจ้าาาาาาาา
                    /*Row(
                      children: <Widget>[
                        Expanded(
                          child: (TextField(
                            decoration: const InputDecoration(
                              labelText: 'กรอกจังหวัด',
                              border: OutlineInputBorder(),
                            ),
                            controller: _textControllerdetectinfo,
                            onChanged: (value) async {
                              Set<String> filteredOptions = _listprovince
                                  .where((option) => option.startsWith(value))
                                  .toSet();
                              setState(() {
                                _listprovince = filteredOptions;
                              });
                            },
                          )),
                        ),
                        SizedBox(width: 50),
                        Expanded(
                          child: DropdownButton(
                            hint: Text('เลือกจังหวัด'),
                            value: _selectedprovince,
                            items: _listprovince
                                .map((option) => DropdownMenuItem(
                                      value: option,
                                      child: Text(option),
                                    ))
                                .toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedprovince = newValue!;
                                _textControllerdetectinfo.text = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),*/
                    Row(
                      children: [
                        const SizedBox(child: Icon(Icons.key)),
                        const SizedBox(width: 20),
                        const SizedBox(child: Text('จังหวัด')),
                        SizedBox(
                            width: 400, // set a fixed width
                            child: Autocomplete<String>(
                              optionsBuilder:
                                  (TextEditingValue textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable<String>.empty();
                                }
                                return _listprovince.where((String option) {
                                  return option.contains(
                                      textEditingValue.text.toLowerCase());
                                });
                              },
                              onSelected: (String selection) {
                                if (selection.isEmpty) {
                                  saveprovince = '';
                                } else {
                                  debugPrint('You just selected $selection');
                                  saveprovince = selection;
                                }
                              },
                            )),
                      ],
                    ),

                    const SizedBox(height: 10),
                    /*TextFormField(
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
                    ),*/
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
                              if (_formKey.currentState!.validate() &
                                  saveprovince!.isNotEmpty) {
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
                              } else if (saveprovince == '') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('กรุณาเลือกจังหวัด'),
                                  duration: const Duration(seconds: 10),
                                ));
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
