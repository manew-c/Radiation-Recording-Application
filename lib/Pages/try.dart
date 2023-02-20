import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class tryPage extends StatefulWidget {
  const tryPage({super.key});

  @override
  State<tryPage> createState() => _tryPageState();
}

class _tryPageState extends State<tryPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();
  List<String> _options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  GlobalKey<AutoCompleteTextFieldState<String>> _autoCompleteKeyprovince =
      GlobalKey();
  String? out;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ข้อมูลPROJECT'),
        ),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoCompleteTextField<String>(
                      key: _autoCompleteKeyprovince,
                      controller: _textEditingController,
                      clearOnSubmit: false,
                      suggestions: _options,
                      itemBuilder: (context, suggestion) =>
                          ListTile(title: Text(suggestion)),
                      itemFilter: (suggestion, input) => suggestion
                          .toLowerCase()
                          .startsWith(input.toLowerCase()),
                      itemSorter: (a, b) => a.compareTo(b),
                      textChanged: (suggestion) {
                        _textEditingController.text = suggestion;
                        out = suggestion;
                      },
                      itemSubmitted: (data) {
                        out = data;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (out?.isEmpty == false) {
                                debugPrint('มีค่าout $out ');
                              } else {
                                debugPrint('ไม่มีค่าถึงปุ่มกด $out ');
                              }
                            },
                            child: Text(
                                'บันทึก'), //หน้าเลือกก็คือให้เลือก ไม่ต้องเช็ค เช็คแค่กรอกไม่กรอกพอ
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
