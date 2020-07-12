import 'package:flutter/material.dart';

// 유통기한을 등록할 때 사용할 date picker 위젯
class ExpireDatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpireDatePickerState();
  }
}

class _ExpireDatePickerState extends State<ExpireDatePicker> {
  DateTime pickedDate; // 선택한 날짜 변수
  TimeOfDay pickedTime; // 선택한 시간 변수

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    pickedTime = TimeOfDay.now();
  }

  void _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 20),
    );

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay time =
        await showTimePicker(context: context, initialTime: pickedTime);

    if (time != null) {
      setState(() {
        pickedTime = time;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '날짜선택',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('날짜 선택')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(
                    '만료일자: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text('만료시간: ${pickedTime.hour}:${pickedTime.minute}'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickTime,
              )
            ],
          ),
        ),
      ),
    );
  }
}
