import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; //ใช้แปะtimestamp
import 'package:string_validator/string_validator.dart'; //เป็นเครื่องเช็ค
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart'; //ใช้ลิ้งเว็บ
import 'package:flutter_application_1/Pages/allvariable.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});
  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final _formKey = GlobalKey<FormState>();
  late Position userlocation;
  late GoogleMapController mapController;

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
              Text('งาน ${Point.worksite} จังหวัด ${Point.province}'),
              Text('ผู้ใช้ ${user.username} หัววัด ${user.detector}'),
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
                children: <Widget>[
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
                    padding: const EdgeInsets.all(8.0),
                    child: AlertDialog(
                      title: Text(
                          'Your location!\nlat: ${userlocation.latitude} long: ${userlocation.longitude} '),
                      content: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
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
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'กรอกค่าDoseที่ 5 cm',
                                  labelText: 'Dose ที่ 5 cm',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == '' ||
                                      isNumeric(value!) == false) {
                                    return 'Please enter Doseที่ 5 cm';
                                  } else {}
                                  return null;
                                },
                                onSaved: (value) =>
                                    MAP.dose5cm = double.parse(value!),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'กรอกค่าDoseที่ 1 m',
                                  labelText: 'dose ที่1m',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == '' ||
                                      isNumeric(value!) == false) {
                                    return 'Please enter Doseที่ 1 m';
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    MAP.dose1m = double.parse(value!),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'กรอกหมายเหตุ',
                                  labelText: 'หมายเหตุ',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value! == '') {
                                    return 'Please enter หมายเหตุ';
                                  }
                                  return null;
                                },
                                onSaved: (value) => MAP.note = value!,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    CollectionReference siteandprovind =
                                        FirebaseFirestore.instance
                                            .collection('ไซต์งาน');
                                    siteandprovind
                                        .doc(Point.worksite)
                                        .collection('ผู้วัดรังสี')
                                        .doc(user.username)
                                        .collection('หัววัด')
                                        .doc(user.detector)
                                        .collection('ชื่อจุด')
                                        .doc(MAP.pointname)
                                        .set({
                                      'dose1m': MAP.dose1m,
                                      'dose5cm': MAP.dose5cm,
                                      'lat': userlocation.latitude,
                                      'long': userlocation.longitude,
                                      'note': MAP.note,
                                      'time': Timestamp.now(),
                                    });
                                    _formKey.currentState!.reset();

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'บันทึกจุด${MAP.pointname}เรียบร้อย   โดสที่5cm ${MAP.dose5cm}  โดสที่1m ${MAP.dose1m}'),
                                      duration: Duration(seconds: 10),
                                    ));
                                  }

                                  /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => survey()),
                            );*/
                                },
                                child: Center(child: Text("Submit")),
                              ),
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
                                child: Text('กดดูcontour map'),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              );
            },
            label: Text("Send Location"),
            icon: Icon(Icons.near_me),
          ),
        ],
      ),
    );
  }
}

/*
ตัวแปร
${userlocation.latitude} long: ${userlocation.longitude
*/
/*class _gpsclass {
  String pointname;
  double dose5cm;
  double dose1m;
  String note;
  _gpsclass(
      {required this.pointname,
      required this.dose5cm,
      required this.dose1m,
      required this.note});
}

_gpsclass MAP = _gpsclass(pointname: '', dose5cm: -1, dose1m: -1, note: '');*/
