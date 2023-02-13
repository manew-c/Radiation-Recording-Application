import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Autopage extends StatefulWidget {
  @override
  _AutopageState createState() => _AutopageState();
}

class _AutopageState extends State<Autopage> {
  final CollectionReference _worksitecollection =
      FirebaseFirestore.instance.collection('allworksite');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  List<String> _listautoworksite = <String>[];
  List<String> _filteredworksite = [];
  List<String> _filteredprovince = [];
  List<String> _listautoprovince = <String>[
    'กรุงเทพมหานคร',
    'จังหวัดกระบี่',
    'จังหวัดกาญจนบุรี',
    'จังหวัดกาฬสินธุ์',
    'จังหวัดกำแพงเพชร',
    'จังหวัดขอนแก่น',
    'จังหวัดจันทบุรี',
    'จังหวัดฉะเชิงเทรา',
    'จังหวัดชลบุรี',
    'จังหวัดชัยนาท',
    'จังหวัดชัยภูมิ',
    'จังหวัดชุมพร',
    'จังหวัดเชียงราย',
    'จังหวัดเชียงใหม่',
    'จังหวัดตรัง',
    'จังหวัดตราด',
    'จังหวัดตาก',
    'จังหวัดนครนายก',
    'จังหวัดนครปฐม',
    'จังหวัดนครพนม',
    'จังหวัดนครราชสีมา',
    'จังหวัดนครศรีธรรมราช',
    'จังหวัดนครสวรรค์',
    'จังหวัดนนทบุรี',
    'จังหวัดนราธิวาส',
    'จังหวัดน่าน',
    'จังหวัดบึงกาฬ',
    'จังหวัดบุรีรัมย์',
    'จังหวัดปทุมธานี',
    'จังหวัดประจวบคีรีขันธ์',
    'จังหวัดปราจีนบุรี',
    'จังหวัดปัตตานี',
    'จังหวัดพระนครศรีอยุธยา',
    'จังหวัดพะเยา',
    'จังหวัดพังงา',
    'จังหวัดพัทลุง',
    'จังหวัดพิจิตร',
    'จังหวัดพิษณุโลก',
    'จังหวัดเพชรบุรี',
    'จังหวัดเพชรบูรณ',
    'จังหวัดแพร่',
    'จังหวัดภูเก็ต',
    'จังหวัดมหาสารคาม',
    'จังหวัดมุกดาหาร',
    'จังหวัดแม่ฮ่องสอน',
    'จังหวัดยโสธร',
    'จังหวัดยะลา',
    'จังหวัดร้อยเอ็ด',
    'จังหวัดระนอง',
    'จังหวัดระยอง',
    'จังหวัดราชบุรี',
    'จังหวัดลพบุรี',
    'จังหวัดลำปาง',
    'จังหวัดลำพูน',
    'จังหวัดเลย',
    'จังหวัดศรีสะเกษ',
    'จังหวัดสกลนคร',
    'จังหวัดสงขลา',
    'จังหวัดสตูล',
    'จังหวัดสมุทรปราการ',
    'จังหวัดสมุทรสงคราม',
    'จังหวัดสมุทรสาคร',
    'จังหวัดสระแก้ว',
    'จังหวัดหนองบัวลำภู',
    'จังหวัดสระบุรี',
    'จังหวัดสิงห์บุรี',
    'จังหวัดสุโขทัย',
    'จังหวัดสุพรรณบุรี',
    'จังหวัดสุราษฎร์ธานี',
    'จังหวัดสุรินทร์',
    'จังหวัดหนองคาย',
    'จังหวัดอ่างทอง',
    'จังหวัดอำนาจเจริญ',
    'จังหวัดอุดรธานี',
    'จังหวัดอุตรดิตถ์',
    'จังหวัดอุทัยธานี',
    'จังหวัดอุบลราชธานี'
  ];

  @override
  void initState() {
    super.initState();
    _worksitecollection.get().then((_docsnapshot) {
      for (var result in _docsnapshot.docs) {
        _listautoworksite.add(result.id);
      }
    });
  }

  void _worksitefunction(String value) {
    setState(() {
      _filteredworksite = _listautoworksite
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _provincefunction(String value) {
    setState(() {
      _filteredprovince = _listautoprovince
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _selectworksite(String _suggestion) {
    _textEditingController.text = _suggestion;
    setState(() {
      _filteredworksite = [];
    });
  }

  void _selectprovince(String _suggestion) {
    _textEditingController.text = _suggestion;
    setState(() {
      _filteredprovince = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("หน้าไซต์งานทดสอบdropdown"),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "กรุณากรอกไซต์งาน",
                        border: OutlineInputBorder(),
                        labelText: 'ไซต์งาน',
                      ),
                      onChanged: (value) => _worksitefunction(value),
                    ),
                    SizedBox(
                        height: 100.0,
                        child: _filteredworksite.isEmpty
                            ? Container()
                            : ListView.builder(
                                itemCount: _filteredworksite.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () => _selectworksite(
                                        _filteredworksite[index]),
                                    child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          _filteredworksite[index],
                                          style: TextStyle(fontSize: 18.0),
                                        )),
                                  );
                                },
                              )),
                    TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "กรุณากรอกจังหวัด",
                        border: OutlineInputBorder(),
                        labelText: 'จังหวัด',
                      ),
                      onChanged: (value) => _provincefunction(value),
                    ),
                    SizedBox(
                        height: 200.0,
                        child: _filteredprovince.isEmpty
                            ? Container()
                            : ListView.builder(
                                itemCount: _filteredprovince.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () => _selectprovince(
                                        _filteredprovince[index]),
                                    child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          _filteredprovince[index],
                                          style: TextStyle(fontSize: 18.0),
                                        )),
                                  );
                                },
                              )),
                    ElevatedButton(
                      onPressed: () async {
                        final url = 'https://nuclear-app-cf4ef.web.app/';
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text('กดดูcontour map'),
                    ),
                  ],
                ),
              ),
            )));
  }
}
