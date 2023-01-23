import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late double _currentSliderValue;
  String? _sliderStatus;
  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference dataRef = FirebaseDatabase.instance.ref('data');

  late DatabaseReference counterRef;
  late StreamSubscription counterStream;

  void _reset() {
    setState(() {
      counterRef.set(0);
    });
  }

  @override
  void initState() {
    super.initState();
    _currentSliderValue = 0;

    counterRef = dataRef.child('counter');
    counterStream = counterRef.onValue.listen((event) {
      //print(event.snapshot.value);
      setState(() {
        _currentSliderValue = event.snapshot.value as double;
      });
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _currentSliderValue = data as double;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_currentSliderValue",
                style: const TextStyle(color: Colors.black)),
            Container(
              width: 400,
              child: CupertinoSlider(
                key: const Key("slider"),
                value: _currentSliderValue,
                divisions: 10,
                max: 100,
                activeColor: CupertinoColors.systemGreen,
                thumbColor: CupertinoColors.systemGreen,
                onChangeStart: (double value) {
                  setState(() {
                    _sliderStatus = "Sliding";
                  });
                },
                onChangeEnd: (double value) {
                  setState(() {
                    _sliderStatus = "Finished Sliding";
                  });
                },
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    counterRef.set(_currentSliderValue);
                  });
                },
              ),
            ),
            Text(
              _sliderStatus ?? "",
              style: CupertinoTheme.of(context)
                  .textTheme
                  .textStyle
                  .copyWith(fontSize: 12),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: _reset,
                        child: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text("Reset"),
                              ),
                              Icon(Icons.replay_outlined),
                            ],
                          ),
                        )),
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: SizedBox(
                        width: 86,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text("Go Back"),
                            ),
                            Icon(Icons.arrow_back),
                          ],
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
