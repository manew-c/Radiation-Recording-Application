import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Autopage extends StatefulWidget {
  const Autopage({super.key});

  @override
  _AutopageState createState() => _AutopageState();
}

class _AutopageState extends State<Autopage> {
  String? out;
  final _formKey = GlobalKey<FormState>();
  final CollectionReference _worksitecollection =
      FirebaseFirestore.instance.collection('allworksite');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _textworksiteController = TextEditingController();
  TextEditingController _textprovinceController = TextEditingController();
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
  String? saveworksite;
  String? saveprovince;

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
    _textworksiteController.text = _suggestion;
    setState(() {
      _filteredworksite = [];
    });
  }

  void _selectprovince(String _suggestion) {
    _textprovinceController.text = _suggestion;
    setState(() {
      _filteredprovince = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("หน้าไซต์งานทดสอบdropdown"),
        ),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    /*
                    TextFormField(
                      controller: _textworksiteController,
                      decoration: InputDecoration(
                        hintText: "กรุณากรอกไซต์งาน",
                        border: OutlineInputBorder(),
                        labelText: 'ไซต์งาน',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'หากไม่มีโปรดใส่เครื่องหมาย - ';
                        }
                        return null;
                      },
                      onChanged: (value) => _worksitefunction(value),
                      onSaved: (_textworksiteController) =>
                          saveworksite = _textworksiteController,
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
                              )),*/
                    const Text(
                      'เลือกจังหวัด',
                      textAlign: TextAlign.left,
                    ),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return _listautoprovince.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        debugPrint('You just selected $selection');
                        out = selection;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (out != '') {
                          /*if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          debugPrint(saveworksite);
                          debugPrint(saveprovince);*/

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('บันทึกไซต์งาน  $out เรียบร้อย'),
                            duration: const Duration(seconds: 4),
                          ));

                          /*FirebaseFirestore.instance
                              .collection("allworksite")
                              .doc(saveworksite)
                              .set({
                            'จังหวัด': saveprovince,
                          });*/
                          //_formKey.currentState!.reset();
                        }
                      }, //อย่าลืมเปลี่ยนpageกลับมาเหมือนเดิมนาจาาา
                      child: const Text('บันทึก'),
                    ),
                    const SizedBox(height: 30), //ช่องว่างเฉยๆ
                    ElevatedButton(
                      onPressed: () async {
                        const url = 'https://nuclear-app-cf4ef.web.app/';
                        final uri = Uri.encodeFull(url);
                        if (await canLaunchUrlString(uri)) {
                          await launchUrlString(uri);
                        } else {
                          throw 'Could not launch $uri';
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
