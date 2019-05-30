import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Modifier extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Modifier();
  }
}

class _Modifier extends State<Modifier> {
  bool hide = true;
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    print("hide: " + this.hide.toString());
    if (this.hide) {
      return BottomAppBar(
        notchMargin: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.all(16),
                // color: Colors.blue,
                child: Row(
                  children: <Widget>[
                    Text(
                      "Take a note...",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                        //backgroundColor: Colors.red
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  this.setState(() {
                    this.hide = !this.hide;
                    this.startTime = DateTime.now();
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else {
      return BottomAppBar(
        notchMargin: 0,
        child: Container(
          height: 204,
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    color: Colors.black38,
                    icon: Icon(
                      Icons.check,
                    ),
                    onPressed: () {
                      this.setState(() {
                        this.hide = !this.hide;
                      });
                    },
                  ),
                  IconButton(
                    color: Colors.black38,
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      this.setState(() {
                        this.hide = !this.hide;
                      });
                    },
                  )
                ],
              ),
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Add a note...",
                ),
              ),
              FlatButton(
                child: Text("Start time: ${startTime.toString()}"),
                onPressed: () {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    this.setState(() => this.startTime = date);
                  }, currentTime: this.startTime, locale: LocaleType.zh);
                },
              ),
              FlatButton(
                child: Text("End time"),
                onPressed: () {
                  DatePicker.showDateTimePicker(context, showTitleActions: true,
                      onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: LocaleType.zh);
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
