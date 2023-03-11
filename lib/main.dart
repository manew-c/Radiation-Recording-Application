import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_application_1/Pages/saveuser.dart';
import 'package:flutter_application_1/Pages/saveworksite.dart';
import 'package:flutter_application_1/Pages/newuserpage.dart';
import 'package:flutter_application_1/Pages/savedetector.dart';
import 'package:flutter_application_1/Pages/Image.dart';
import 'Provider/Transaction_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(const MyApp());
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
          home: const MyHomePage(),
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
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color.fromARGB(255, 248, 184, 45)])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Radiation Recording"),
            actions: [const Icon(Icons.album_outlined)],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ยินดีต้อนรับ', style: TextStyle(fontSize: 20)),
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const newuserpage(), //เปลี่ยนหน้autoตรงนนี้จ้า
                                  ));
                            },
                            child: const Text(
                              'start',
                              style: TextStyle(fontSize: 18),
                            ))),
                    const SizedBox(height: 30), //อันนี้คือให้มันเว้นช่อง
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const saveworksitePage(), //เปลี่ยนหน้าloadตรงนนี้จ้า
                                  ));
                            },
                            child: const Text(
                              'บันทึกข้อมูลไซต์งาน',
                              style: TextStyle(fontSize: 18),
                            ))),
                    const SizedBox(height: 30), //อันนี้คือให้มันเว้นช่อง
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const saveuserPage(), //เปลี่ยนหน้userตรงนนี้จ้า
                                  ));
                            },
                            child: const Text(
                              'บันทึกชื่อผู้ใช้งาน',
                              style: TextStyle(fontSize: 18),
                            ))),
                    const SizedBox(height: 30), //อันนี้คือให้มันเว้นช่อง
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const savedetectorPage(), //เปลี่ยนหน้าdetectorตรงนี้จ้า
                                  ));
                            },
                            child: const Text(
                              'บันทึกข้อมูลหัววัดรังสี',
                              style: TextStyle(fontSize: 18),
                            ))),
                    const SizedBox(height: 30), //อันนี้คือให้มันเว้นช่อง
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              const url = 'https://nuclear-app-cf4ef.web.app/';
                              final uri = Uri.encodeFull(url);
                              if (await canLaunchUrlString(uri)) {
                                await launchUrlString(uri);
                              } else {
                                throw 'Could not launch $uri';
                              }
                            },
                            child: const Text(
                              'ไปหน้าเว็บไซต์',
                              style: TextStyle(fontSize: 18),
                            ))),
                    const SizedBox(height: 30), //อันนี้คือให้มันเว้นช่อง
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const Imagepage(), //เปลี่ยนหน้าdetectorตรงนี้จ้า
                                  ));
                            },
                            child: const Text(
                              'คู่มือใช้งานแอป',
                              style: TextStyle(fontSize: 18),
                            ))),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
/*  
อันนี้คือขออนุญาต แต่ไม่รุ้จะใส่ตรงไหน
if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
            != PackageManager.PERMISSION_GRANTED) {
    ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, REQUEST_CODE);
}

*/