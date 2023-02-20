import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String _docName = "";
  String _docData = "";
  TextEditingController _docNameController = TextEditingController();

  // Firebase Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void _getData() {
    //String _docName = _docNameController.text; // Get the document name from the text field
    firestore
        .collection("allworksite")
        .doc(_docName)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // The data is retrieved as a map
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Access the fields in the map using their keys
        String field1 = data["จังหวัด"];

        // Do something with the retrieved data
      } else {
        return '88';
        // The document does not exist
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Text field for inputting the document name
            TextField(
              onChanged: (value) {
                setState(() {
                  _docName = value;
                });
              },
            ),
            // Button to trigger the Firebase Firestore query
            ElevatedButton(
              onPressed: _getData,
              child: Text("Get Data"),
            ),
            // Container to display the retrieved data
            Container(
              child: Text(_docData),
            ),
          ],
        ),
      ),
    );
  }
}

/*StreamBuilder(
                      stream:
                          worksitedatabaseReference.doc(_docname).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData & _docname!.isNotEmpty) {
                          debugPrint('มีค่าout= $_docname ');
                          Map<dynamic, dynamic> data = snapshot.data;
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('จังหวัด: ${data['จังหวัด']}'),
                              ],
                            ),
                          );

                          return Text('ok');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    */