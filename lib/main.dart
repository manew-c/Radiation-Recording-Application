import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/informationPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_application_1/Pages/autopage.dart';
import 'Provider/Transaction_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(MyApp());
}

//สร้าง widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (Buildcontext) {
            return Transaction_provider();
          })
        ],
        child: MaterialApp(
          title: "My App",
          home: MyHomePage(),
          theme: ThemeData(primarySwatch: Colors.amber),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //การสร้างstate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radiation Recording"),
        actions: [Icon(Icons.album_outlined)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ยินดีต้อนรับ'),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => informationPage(),
                              ));
                        },
                        child: const Text(
                          'New Project',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ),
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Autopage(), //เปลี่ยนหน้าloadตรงนนี้จ้า
                              ));
                        },
                        child: const Text(
                          'Load',
                          style: TextStyle(fontSize: 18),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
