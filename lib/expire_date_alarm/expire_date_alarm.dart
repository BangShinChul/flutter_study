import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ExpireDateAlarm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpireDateAlarmState();
  }
}

class _ExpireDateAlarmState extends State<ExpireDateAlarm> {
  String _itemName = null; // 등록할 상품 이름
  DateTime _pickedDateTime = DateTime.now(); // 선택한 유통기한 최종 만료날짜 변수
  DateTime _pickedDate = DateTime.now(); // 선택한 유통기한 만료 일자용 변수
  DateTime _pickedTime = DateTime.now(); // 선택한 유통기한 만료 시간용 변수

  String _pickedDateTitle = null;
  String _pickedTimeTitle = null;

  String _alartDate = null; // 알림받을 시간. 예) 1일전, 3일전, 5일전
  bool _isPickedDateFlag = false; // 유통기한 일자 선택여부 체크용 변수
  bool _isPickedTimeFlag = false; // 유통기한 시간 선택여부 체크용 변수

  // @override
  // void initState() {
  //   // 초기화 함수
  //   super.initState();
  //   itemName = null;
  //   isPickedDateFlag = false;
  //   isPickedTimeFlag = false;
  //   pickedDateTime = DateTime.now();
  //   pickedDate = DateTime.now();
  //   pickedTime = DateTime.now();
  // }

  void _addExpireItem() {
    // 여기서 유통기한을 등록할 식품정보를 입력할 수 있는 팝업을 띄워주는 동작을 한다.
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return MaterialApp(
            title: '유통기한 등록',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Text('유통기한 등록'),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              body: _addExpireItemForm(),
            ));
      }),
    );
  }

  void _addExpireItemToDB() {
    // 실제로 입력받은 정보를 DB에 저장하여 유통기한을 등록하는 함수
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('입력데이터 확인'),
              content: Text(
                  '제품명: $_itemName / 최종날짜: $_pickedDateTime / 일자: $_pickedDate / 시간: $_pickedTime'),
            ));
  }

  void _setItemName(String name) {
    print('setting item name : $name');
    setState(() {
      _itemName = name;
    });
  }

  void _setPickedDate(DateTime date) {
    print('setting pickedDate : $date');
    setState(() {
      _pickedDate = date;
      _pickedDateTitle = DateFormat('yyyy-MM-dd').format(date);
      _isPickedDateFlag = true;
      _pickedDateTime = new DateTime(date.year, date.month, date.day,
          _pickedTime.hour, _pickedTime.minute);
    });
  }

  void _setPickedTime(DateTime time) {
    print('setting pickedTime : $time');
    setState(() {
      _pickedTime = time;
      _pickedTimeTitle = DateFormat('kk:mm').format(time);
      _isPickedTimeFlag = true;
      _pickedDateTime = new DateTime(_pickedDate.year, _pickedDate.month,
          _pickedDate.day, time.hour, time.minute);
    });
  }

  // 유통기한을 등록하는 Form
  Widget _addExpireItemForm() {
    return Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(
                  hintText: '예) 계란 한판, 우유 등',
                  labelText: '제품명',
                  border: OutlineInputBorder()),
              onChanged: (value) => _setItemName(value),
            ),
            new Text('입력한 제품명: ${this._itemName}'),
            FlatButton(
              child: _isPickedDateFlag
                  ? Text('일자선택: $_pickedDateTitle')
                  : Text('일자선택'),
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2018, 1, 1),
                    maxTime: DateTime(2030, 12, 31),
                    onChanged: (date) => {
                          print('date change $date'),
                        },
                    onConfirm: (date) =>
                        {print('date confirm $date'), _setPickedDate(date)},
                    currentTime: DateTime.now(),
                    locale: LocaleType.ko);
              },
            ),
            FlatButton(
              child: _isPickedTimeFlag
                  ? Text('시간선택: ${_pickedTimeTitle}')
                  : Text('시간선택'),
              onPressed: () {
                DatePicker.showTime12hPicker(context,
                    showTitleActions: true,
                    onChanged: (time) => {print('time change $time')},
                    onConfirm: (time) =>
                        {print('time confirm $time'), _setPickedTime(time)},
                    currentTime: DateTime.now(),
                    locale: LocaleType.ko);
              },
            ),
            new DropdownButton<String>(
                value: _alartDate,
                items: <String>['1', '2', '3', '4', '5']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => setState(() => _alartDate = value)),
            new Text('유통기한: $_pickedDateTime'),
            FlatButton(
              onPressed: () => _addExpireItemToDB(),
              child: Text('등록하기'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 여기서 등록한 유통기한 만료 알림 리스트를 노출한다.

      // 아래 버튼을 누르면 유통기한 등록 페이지로 리디렉션 된다.
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpireItem,
        tooltip: 'addExpireItem',
        child: Icon(Icons.add),
      ),
    );
  }
}
