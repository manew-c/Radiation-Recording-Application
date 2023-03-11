import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //ใช้แปะtimestamp
import 'package:string_validator/string_validator.dart'; //เป็นเครื่องเช็ค
import 'package:url_launcher/url_launcher_string.dart'; //ใช้ลิ้งเว็บ
import 'package:flutter_application_1/Pages/allvariable.dart';
import 'package:toggle_switch/toggle_switch.dart'; //ปุ่มแบบtoggle
import 'package:image_picker/image_picker.dart'; //อัพรูปภาพ
import 'dart:io'; //ใช้ fileได้
import 'package:firebase_storage/firebase_storage.dart'; //อัพรรูป

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final _formKey = GlobalKey<FormState>();
  late Position userlocation;
  late GoogleMapController mapController;
  String? _selectedunit5cm;
  String? _selectedunit1m;
  XFile? _pickedImage; // State variable to store the picked file
  String? _pickedImageName; // State variable to store the file name

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = XFile(pickedFile.path);
        _pickedImageName = pickedFile.path.split('/').last;
      });
    }
  }

  DocumentReference<Map<String, dynamic>> detectordatabase = FirebaseFirestore
      .instance
      .collection('หัววัดall')
      .doc(start.selecteddetector);

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetectorName() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await detectordatabase.get();
    return snapshot;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userlocation = await Geolocator.getCurrentPosition();
    return userlocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Flexible(
          child: Column(
            children: <Widget>[
              Text('ไซต์งาน ${start.selectedworksite} '),
              Text(
                  'ผู้ใช้ ${start.selectedusername} หัววัด ${start.selecteddetector}'),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: _getLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(userlocation.latitude, userlocation.longitude),
                zoom: 15,
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                  Text('กำลังโหลด'),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              mapController.animateCamera(CameraUpdate.newLatLngZoom(
                  LatLng(userlocation.latitude, userlocation.longitude), 18));
              showDialog(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    //padding: const EdgeInsets.all(8.0),
                    child: AlertDialog(
                      title: Text(
                          'Your location!\nlat: ${userlocation.latitude} long: ${userlocation.longitude} '),
                      actions: [
                        // add buttons here
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                const url =
                                    'https://nuclear-app-cf4ef.web.app/';
                                final uri = Uri.encodeFull(url);
                                if (await canLaunchUrlString(uri)) {
                                  await launchUrlString(uri);
                                } else {
                                  throw 'Could not launch $uri';
                                }
                              },
                              child: const Text('กดดูcontour map'),
                            ),
                            ElevatedButton(
                              child: const Text(
                                "Close",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                      content: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'กรอกชื่อจุด',
                                labelText: 'ชื่อจุด',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value! == '') {
                                  return 'Please enter ชื่อจุด';
                                }
                                return null;
                              },
                              onSaved: (value) => MAP.pointname = (value!),
                            ),
                            const SizedBox(height: 10),

                            TextFormField(
                              decoration: const InputDecoration(
                                hintText:
                                    'กรอกค่าDoseที่ 5 cm กรอกหรือไม่กรอกก็ได้',
                                labelText: 'Dose ที่ 5 cm',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                //อันนี้มันoptional
                                if (isFloat(value!) == false) {
                                  return 'ค่าที่กรอกไม่ใช่ตัวเลข';
                                }
                                return null; //อย่าลืมแก้
                              },
                              onSaved: (value) {
                                if (value!.isNotEmpty == true) {
                                  MAP.dose5cm = double.parse(value);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            //ใส่dropอันที่1
                            ToggleSwitch(
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              labels: const ['µSv/h', 'nSv/h'],
                              onToggle: (index) {
                                if (index == 0) {
                                  _selectedunit5cm = 'µSv/h';
                                } else {
                                  _selectedunit5cm = 'nSv/h';
                                }
                                debugPrint('unit5cm to: $_selectedunit5cm');
                              },
                            ),
                            /*DropdownButton<String>(
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'µSv/h',
                                  child: Text('µSv/h'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'nSv/h',
                                  child: Text('nSv/h'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedunit5cm = value;
                                });
                              },
                              hint: const Text('เลือกหน่วย'),
                              value: _selectedunit5cm,
                            ),*/

                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'กรอกค่าDoseที่ 1 m',
                                labelText: 'Dose ที่1m',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == '') {
                                  return 'โปรดใส่ค่า Doseที่ 1 m';
                                } else if (isFloat(value!) == false) {
                                  return 'ค่าที่กรอกไม่ใช่ตัวเลข';
                                }
                                return null;
                              },
                              onSaved: (value) =>
                                  MAP.dose1m = double.parse(value!),
                            ),
                            const SizedBox(height: 10),
                            ToggleSwitch(
                              initialLabelIndex: 0,
                              totalSwitches: 2,
                              labels: const ['µSv/h', 'nSv/h'],
                              onToggle: (index) {
                                if (index == 0) {
                                  _selectedunit1m = 'µSv/h';
                                } else {
                                  _selectedunit1m = 'nSv/h';
                                }
                                debugPrint('unit1m to: $_selectedunit1m');
                              },
                            ),

                            //อันที่2
                            /*DropdownButton<String>(
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'µSv/h',
                                  child: Text('µSv/h'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'nSv/h',
                                  child: Text('nSv/h'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedunit1m = value;
                                });
                              },
                              hint: const Text('เลือกหน่วย'),
                              value: _selectedunit1m,
                            ),*/

                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'กรอกหมายเหตุ',
                                labelText: 'หมายเหตุ',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value! == '') {
                                  return 'หากไม่มีกรุณากรอก - ';
                                }
                                return null;
                              },
                              onSaved: (value) => MAP.note = value!,
                            ),

                            ElevatedButton(
                                onPressed: _getImage,
                                child: const Text(
                                  'เพิ่มรูปภาพ',
                                  style: TextStyle(fontSize: 18),
                                )),

                            if (_pickedImage != null)
                              SizedBox(
                                height: 200,
                                child: Image.file(File(_pickedImage!.path)),
                              ),
                            SizedBox(
                                child: Text(
                                    _pickedImageName ?? 'No image selected')),

                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate() &&
                                    _pickedImage?.path != null) {
                                  _formKey.currentState!.save();
                                  final DocumentSnapshot<Map<String, dynamic>>
                                      snapshot = await getDetectorName();
                                  final Map<String, dynamic>? dato =
                                      snapshot.data();
                                  final double conversion =
                                      dato!['conversionfactor'].toDouble();
                                  CollectionReference siteandprovind =
                                      FirebaseFirestore.instance
                                          .collection('ไซต์งาน');
                                  siteandprovind
                                      .doc(start.selectedworksite)
                                      .collection('ผู้วัดรังสี')
                                      .doc(start.selectedusername)
                                      .collection('หัววัด')
                                      .doc(start.selecteddetector)
                                      .collection('ชื่อจุด')
                                      .doc(MAP.pointname)
                                      .set({
                                    'dose1m': MAP.dose1m,
                                    'conversion_dose1m':
                                        MAP.dose1m * conversion,
                                    'doseunit1m': _selectedunit1m,
                                    'dose5cm': MAP.dose5cm * conversion,
                                    'conversion_dose5cm':
                                        MAP.dose5cm * conversion,
                                    'doseunit5cm': _selectedunit5cm,
                                    'lat': userlocation.latitude,
                                    'long': userlocation.longitude,
                                    'note': MAP.note,
                                    'time': Timestamp.now(),
                                    //'pic': File(_pickedImage),
                                  });

                                  final storageRef = FirebaseStorage.instance
                                      .ref()
                                      .child('image');
                                  try {
                                    final UploadTask uploadTask = storageRef
                                        .putFile(File(_pickedImage!.path));
                                    await uploadTask;
                                    final String downloadUrl =
                                        await storageRef.getDownloadURL();
                                    debugPrint(
                                        'Upload successful! Download URL: $downloadUrl');
                                    debugPrint('ส่งรูปแล้ว');
                                  } catch (e) {
                                    debugPrint('ส่งรูปไม่ได้');
                                    debugPrint(_pickedImage!.path);
                                  }
//gs://nuclear-app-cf4ef.appspot.com/image
                                  _formKey.currentState!.reset();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'บันทึกจุด${MAP.pointname}เรียบร้อย   โดสที่5cm ${MAP.dose5cm}  โดสที่1m ${MAP.dose1m}'),
                                    duration: const Duration(seconds: 10),
                                  ));
                                }

                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => survey()),
                                );*/
                              },
                              child: const Center(child: Text("Submit")),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            label: const Text("บันทึกค่าdose"),
            icon: const Icon(Icons.near_me),
          ),
        ],
      ),
    );
  }
}
