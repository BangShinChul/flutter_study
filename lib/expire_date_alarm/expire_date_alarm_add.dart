import 'package:flutter/material.dart';

class ExpireDateAlarmAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpireDateAlarmAddState();
  }
}

class _ExpireDateAlarmAddState extends State<ExpireDateAlarmAdd> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('유통기한 등록'),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: build(context),
    );
  }
}
