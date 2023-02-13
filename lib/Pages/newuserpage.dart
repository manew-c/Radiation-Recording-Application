import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/informationPage.dart';
import '../map.dart';
import 'package:flutter_application_1/Pages/allvariable.dart';

class newuserpage extends StatefulWidget {
  const newuserpage({Key? key}) : super(key: key);

  @override
  _newuserpageState createState() => _newuserpageState();
}

class _newuserpageState extends State<newuserpage> {
  String? _selectedusername;
  String? _selecteddetector;
  String? _selecteddetecinfo;
  late var _dropdownusername = <String>{};
  late var _dropdowndetector = <String>{};
  late var _dropdowndetectinfo = <String>{};
  final _textControllerusername = TextEditingController();
  final _textControllerdetector = TextEditingController();
  final _textControllerdetectinfo = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDatausername();
    fetchDatadetector();
    fetchDatadetectinfo();
  }

  Future<void> fetchDatausername() async {
    await FirebaseFirestore.instance
        .collection("ชื่อคนall")
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        _dropdownusername.add(result.id);
      }
    });
  }

/*  .collection("ไซต์งาน").doc(Point.worksite).collection('ผู้วัดรังสี').doc(user.username).collection('หัววัด')
                              .doc(user.detector)
                              .collection('ชื่อจุด')
                              .doc(pointname) */
  Future<void> fetchDatadetector() async {
    await FirebaseFirestore.instance
        .collection("หัววัดall")
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        _dropdowndetector.add(result.id);
      }
    });
  }

  Future<void> fetchDatadetectinfo() async {
    await FirebaseFirestore.instance
        .collection("รายละเอียดหัววัดall")
        .get()
        .then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        _dropdowndetectinfo.add(result.id);
      }
    });
  }

/*final datat = doc.data() as Map<String, dynamic>;
      List<dynamic> myList = datat['myList'];
      myList.forEach((item) {
        _dropdowndetector.add(item);
      });*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('USER Page'),
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'กรอกชื่อผู้วัด',
                  border: OutlineInputBorder(),
                ),
                controller: _textControllerusername,
                onChanged: (value) async {
                  Set<String> filteredOptions = _dropdownusername
                      .where((option) => option.startsWith(value))
                      .toSet();
                  setState(() {
                    _dropdownusername = filteredOptions;
                    //_selectedusername = value;//นี่คือส่วนที่เพิ่มมมาเองไม่งั้นมันnullแต่ก็errorพอลบทิ้งก็nullแต่ดันไปหน้าต่อไปได้wtf
                  });
                },
                /*onSubmitted: (value) {
                  debugPrint(value);
                },*/
              ),
              FutureBuilder(
                future: fetchDatausername(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return DropdownButton(
                      value: _selectedusername,
                      items: _dropdownusername
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedusername = newValue!;
                          _textControllerusername.text = newValue;
                        });
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'กรอกหัววัด',
                  border: OutlineInputBorder(),
                ),
                controller: _textControllerdetector,
                onChanged: (value) async {
                  Set<String> filteredOptions = _dropdowndetector
                      .where((option) => option.startsWith(value))
                      .toSet();
                  setState(() {
                    _dropdowndetector = filteredOptions;
                    //_selecteddetector = value;
                  });
                },
              ),
              FutureBuilder(
                future: fetchDatadetector(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return DropdownButton(
                      value: _selecteddetector,
                      items: _dropdowndetector
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selecteddetector = newValue!;
                          _textControllerdetector.text = newValue;
                        });
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'กรอกรายละเอียดหัววัด',
                  border: OutlineInputBorder(),
                ),
                controller: _textControllerdetectinfo,
                onChanged: (value) async {
                  Set<String> filteredOptions = _dropdowndetectinfo
                      .where((option) => option.startsWith(value))
                      .toSet();
                  setState(() {
                    _dropdowndetectinfo = filteredOptions;
                    //_selecteddetecinfo = value;
                  });
                },
              ),
              FutureBuilder(
                future: fetchDatadetectinfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return DropdownButton(
                      value: _selecteddetecinfo,
                      items: _dropdowndetectinfo
                          .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option),
                              ))
                          .toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selecteddetecinfo = newValue!;
                          _textControllerdetectinfo.text = newValue;
                        });
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_selectedusername?.isNotEmpty == true &&
                      _selecteddetector?.isNotEmpty == true &&
                      _selecteddetecinfo?.isNotEmpty == true) {
                    FirebaseFirestore.instance
                        .collection("ไซต์งาน")
                        .doc(Point.worksite)
                        .collection('ผู้วัดรังสี')
                        .doc(_selectedusername)
                        .collection('หัววัด')
                        .doc(_selecteddetector)
                        .set({'รายละเอียดหัววัด': _selecteddetecinfo});
                    FirebaseFirestore.instance
                        .collection("ชื่อคนall")
                        .doc(_selectedusername);
                    FirebaseFirestore.instance
                        .collection("หัววัดall")
                        .doc(_selecteddetector);
                    FirebaseFirestore.instance
                        .collection("รายละเอียดหัววัดall")
                        .doc(_selecteddetector);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsPage(),
                      ),
                    ); //navigator

                  } else {
                    // show an error message
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'โปรดกรอกชื่อ$_selectedusername, หัววัด$_selecteddetector รายละเอียด$_selecteddetecinfo'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                  // Perform action on submit
                },
              ),
            ],
          ),
        ));
  }
}

//กุเหนื่อยแค่กล่องใส่ข้อความกล่องเดียว วิธีแก้คือเปลี่ยนจากlistเป็นset อหหหหหหหหหหหหหห เหน่ย
/*class _pointclasstest {
  String usernamet;
  String detectort;
  String detectinfot;
  _pointclasstest(
      {required this.usernamet,
      required this.detectort,
      required this.detectinfot});
}

_pointclasstest Pointtest =
    _pointclasstest(usernamet: '', detectort: '', detectinfot: '');*/
