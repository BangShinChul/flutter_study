import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(primaryColor: Colors.white),
      // home: RandomWords(),
      home: NotificationTest(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  // Dart 언어에서는 식별자 앞에 밑줄을 붙이면 프라이빗 적용이 됩니다.
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>(); 
  final _biggerFont = const TextStyle(fontSize: 18.0);
  
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            }
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  /*
  _buildSuggestions() 함수는 단어 쌍 마다 한 번 씩 _buildRow()를 호출합니다. 이 함수는 ListTile에서 각각 새로운 쌍을 표시하여 다음 단계에서 행을 더 매력적으로 만들 수 있게 합니다.
  */
  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) { // i는 index입니다. itemBuilder 콜백은 단어 쌍이 제안될 때마다 호출되고 각각을 ListTile 행에 배치합니다. index가 짝수 행인 경우 ListTile 행에 단어 쌍을 추가합니다. 홀수 행인 경우 시각적으로 각 항목을 구분하는 Divider 위젯을 추가합니다. 작은 기기에서는 구분선을 보기 어려울 수 있습니다.
        if (i.isOdd) return Divider(); /*2*/ // ListView의 각 행 앞에 1 픽셀 높이의 구분선 위젯을 추가하십시오. isOdd는 정수가 홀수인 경우에만 true를 리턴합니다.

        final index = i ~/ 2; /*3*/ // i ~/ 2 표현식은 i를 2로 나눈 뒤 정수 결과를 반환합니다. 예를 들어: 1, 2, 3, 4, 5는 0, 1, 1, 2, 2가 됩니다. 이렇게 하면 구분선 위젯을 제외한 ListView에 있는 단어 쌍 수가 계산됩니다.
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/ // 가능한 단어 쌍을 모두 사용하고 나면, 10개를 더 생성하고 제안 목록에 추가합니다.
        }
        return _buildRow(_suggestions[index]);
      });
  }

  Widget _buildRow(WordPair pair) {

    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}


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

  Future _showNotificationAtTime() async {
    var scheduleNotificationDateTime = new DateTime.now().add(new Duration(seconds: 5));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      importance: Importance.Max,
      priority: Priority.High
    );
    var iosPlatformChannelSpecifics = IOSNotificationDetails(sound: 'slow_spring.board.aiff');
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.schedule(
      1, 
      '시간 지정 Notification',
      '5초 후 알림',
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      payload: 'Hello Flutter1',
    );
  }

  Future _showNotificationRepeat() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      importance: Importance.Max,
      priority: Priority.High
    );
    var iosPlatformChannelSpecifics = IOSNotificationDetails(sound: 'slow_spring.board.aiff');
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      '반복 Notification',
      '매 분 반복 알림',
      RepeatInterval.EveryMinute,
      platformChannelSpecifics,
      payload: 'Hello Flutter2'
    );
  }

  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      sound: RawResourceAndroidNotificationSound('slow_spring_board'),
      importance: Importance.Max,
      priority: Priority.High
    );
    var iosPlatformChannelSpecifics = IOSNotificationDetails(sound: 'slow_spring.board.aiff');
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iosPlatformChannelSpecifics);


    await _flutterLocalNotificationsPlugin.show(
      0, 
      '심플 Notification', 
      '심플 Notification 내용', 
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noti Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('기본 Notification'),
              onPressed: _showNotificationWithSound,
            ),
            RaisedButton(
              child: Text('반복 Notification'),
              onPressed: _showNotificationRepeat,
            ),RaisedButton(
              child: Text('지정 Notification'),
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