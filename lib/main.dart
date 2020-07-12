import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import './count/count.dart';
import './random_words/random_word.dart';
import './noti/noti.dart';
import './barcode_scan/barcode_scan.dart';
import './expire_date_alarm/expire_date_alarm.dart';

// Icons 참고 : https://material.io/resources/icons/?style=baseline

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MyCountPage(),
    NotificationTest(),
    RandomWords(),
    BarcodeScan(),
    ExpireDateAlarm()
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '유통기한 알리미',
        home: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              selectedItemColor: Colors.blue,
              onTap: _onTap,
              items: [
                new BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Count'),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  title: Text('Noti'),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Random'),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.camera_enhance),
                  title: Text('QrCodeScanner'),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.alarm),
                  title: Text('유통기한 알리미'),
                ),
              ]),
        ));
  }
}
