import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Notification State
class NotificationTest extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _NotificationTestState();
  }
}

class _NotificationTestState extends State<NotificationTest> {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void initState() {
    super.initState(); // 이 객체가 트리에 삽입 될 때 호출됩니다. 프레임 워크는 생성 된 각 [State] 객체에 대해이 메소드를 정확히 한 번만 호출합니다.
    var androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSetting = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(androidSetting, iosSetting);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings, 
      onSelectNotification: onSelectNotification
    );
  }

  // Future 타입은 비동기 형태로 함수를 작성함을 의미한다.
  // 참고 : https://dart.dev/codelabs/async-await
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Notification Payload'),
        content: Text('Payload: $payload'),
      )
    );
  }

  Future _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('my-flutter-noti-id', 'my-flutter-noti-name', 'this is test noti in time');
    var iosPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(0, 'Simple Noti', '기본 알림입니다.', platformChannelSpecifics, payload: 'Hello world!');
  }

  Future<void> _showNotificationAtTime() async {

    var androidPlatformChannelSpecifics = AndroidNotificationDetails('my-flutter-noti-id', 'my-flutter-noti-name', 'this is test noti in time');
    var iosPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.schedule(
      0,
      '시간 지정 Notification',
      '5초 후 알림',
      DateTime.now().add(Duration(seconds: 60)),
      platformChannelSpecifics,
      payload: '5초 후 알림',
    );
  }

  Future<void> _showNotificationRepeat() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails('my-flutter-noti-id', 'my-flutter-noti-name', 'this is test noti repeat');
    var iosPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '반복 Notification',
      '매 분 반복 알림',
      RepeatInterval.EveryMinute,
      platformChannelSpecifics,
      payload: '매 분 반복 알림'
    );
  }

  // Future _showNotificationWithSound() async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'my-flutter-noti-id', 'my-flutter-noti-name', 'this is test noti with sound',
  //     sound: 'slow_spring_board.mp3',
  //     importance: Importance.Max,
  //     priority: Priority.High
  //   );
  //   var iosPlatformChannelSpecifics = IOSNotificationDetails(sound: 'slow_spring.board.aiff');
  //   var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);


  //   await _flutterLocalNotificationsPlugin.show(
  //     0, 
  //     '심플 Notification', 
  //     '심플 Notification 내용', 
  //     platformChannelSpecifics,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('기본 알림 발송'),
              onPressed: _showNotification,
            ),RaisedButton(
              child: Text('1분마다 알림 반복 발송'),
              onPressed: _showNotificationRepeat,
            ),RaisedButton(
              child: Text('5초 후 알림 발송'),
              onPressed: _showNotificationAtTime,
            ),RaisedButton(
              child: Text('취소'),
              onPressed: () => _flutterLocalNotificationsPlugin.cancelAll(),
            ),
          ],
        )
      ),
    );
  }
}