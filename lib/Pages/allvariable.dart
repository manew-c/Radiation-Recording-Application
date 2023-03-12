import 'package:flutter_application_1/Pages/allvariable.dart';

class _pointclass {
  String worksite;
  String worksitenote;
  String province;
  _pointclass(
      {required this.worksite,
      required this.worksitenote,
      required this.province});
}

_pointclass Point = _pointclass(worksite: '', worksitenote: '', province: '');

class _userclass {
  String username;
  String detector;
  String detectorinformation;
  _userclass(
      {required this.username,
      required this.detector,
      required this.detectorinformation});
}

_userclass user =
    _userclass(username: '', detector: '', detectorinformation: '');

class _gpsclass {
  String pointname;
  double dose5cm;
  double dose1m;
  String note;
  String unit;
  _gpsclass(
      {required this.pointname,
      required this.dose5cm,
      required this.dose1m,
      required this.note,
      required this.unit});
}

_gpsclass MAP =
    _gpsclass(pointname: '', dose5cm: 0, dose1m: 0, note: '', unit: '');

class _startclass {
  String selectedworksite;
  String selectedusername;
  String selecteddetector;
  _startclass(
      {required this.selectedusername,
      required this.selecteddetector,
      required this.selectedworksite});
}

_startclass start = _startclass(
    selectedusername: '', selecteddetector: '', selectedworksite: '');

class _userlocationclass {
  var lat;
  var long;

  _userlocationclass({
    required this.lat,
    required this.long,
  });
}

_userlocationclass userloca = _userlocationclass(
  lat: 0,
  long: 0,
);
