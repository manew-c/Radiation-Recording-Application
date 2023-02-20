import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//หน้านี้คือเอาautocompleteมาจากtry จะเพิ่มช่องแสดงผล
class choosePage extends StatefulWidget {
  const choosePage({Key? key}) : super(key: key);

  @override
  State<choosePage> createState() => _choosePageState();
}

class _choosePageState extends State<choosePage> {
//ไว้ใสตัวแปรต่างๆ
  late void Function(void Function()) _setState;
  CollectionReference worksitedatabaseReference =
      FirebaseFirestore.instance.collection('allworksite');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompleteKeyprovince =
      GlobalKey();
  String? _docname = 'ค่าเริ่มต้น';
  late var _dropdownworksite = <String>[];

//ใส่ฟังชั่นต่างงงง
  @override
  void initState() {
    super.initState();
    fetchDataworksite();
    _setState = setState;
  }

//ฟังชั่นfetchมาจากnewuser
  Future<void> fetchDataworksite() async {
    await FirebaseFirestore.instance
        .collection("allworksite")
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        _dropdownworksite.add(result.id);
      }
    });
  }

  Future<void> pathworksite() async {
    if (_docname != null) {
      worksitedatabaseReference.doc(_docname).snapshots();
    } else {
      return null;
    }
  }

//เหนื่อยโว้ยยยยยย
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เลือกไซต์งาน ผู้วัด และหัววัด'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoCompleteTextField<String>(
                      key: _autoCompleteKeyprovince,
                      controller: _textEditingController,
                      clearOnSubmit: false,
                      suggestions: _dropdownworksite,
                      itemBuilder: (context, suggestion) =>
                          ListTile(title: Text(suggestion)),
                      itemFilter: (suggestion, input) => suggestion
                          .toLowerCase()
                          .startsWith(input.toLowerCase()),
                      itemSorter: (a, b) => a.compareTo(b),
                      textChanged: (suggestion) {
                        _textEditingController.text = suggestion;
                        _docname = suggestion;
                      },
                      itemSubmitted: (data) {
                        _setState(() {
                          _docname = data;
                        });
                      },
                    ),
                    //ใช้autocomplteเหมือนautopageแต่ติดปัญหาตรง _doc null
                    //อันนี้ช่องดึงข้อมูล saveสำรองไว้ที่aaa

                    StreamBuilder(
                      stream:
                          worksitedatabaseReference.doc(_docname).snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading...");
                        } else if (!snapshot.hasData) {
                          return Text("Document does not exist");
                        } else if (snapshot.hasData &&
                            snapshot.data!.data() != null) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                title: Text('จังหวัด' + ' ' + data['จังหวัด']),
                                subtitle: Text('หมายเหตุ' + ' ' + data['note']),
                              )
                            ],
                          );
                        } else {
                          return Text("ไม่มีไซต์งานนี้ ");
                        }
                      },
                    ),

                    //อันนี้ปุ่มกด ต้องไว้ล่างสุดดิ
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_docname?.isEmpty == false) {
                                debugPrint('มีค่าout $_docname ');
                              } else {
                                debugPrint('ไม่มีค่าถึงปุ่มกด $_docname ');
                              }
                            },
                            child: Text(
                                'เลือก'), //หน้าเลือกก็คือให้เลือก ไม่ต้องเช็ค เช็คแค่กรอกไม่กรอกพอ
                          ),
                        ],
                      ),
                    ) //จบปุ่มกดจ้า
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
