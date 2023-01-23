import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_card/page2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomepage());
  }
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Text(
                    "Connor Kremer",
                    style: GoogleFonts.changa(
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 40)),
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  "Student",
                  style: GoogleFonts.lato(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              Container(
                color: Colors.white,
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone_android),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "705-232-1932",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.mail),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          "example@smcdsb.on.ca",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Page2())),
        tooltip: "Next Page",
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
