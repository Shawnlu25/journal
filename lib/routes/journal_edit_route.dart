import 'package:flutter/material.dart';
import 'package:journal/tiled_dashboard.dart';

class JournalEditRoute extends StatefulWidget {
  JournalEditRoute();

  @override
  _JournalEditRouteState createState() => _JournalEditRouteState();
}

class _JournalEditRouteState extends State<JournalEditRoute> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[],
      ),
      bottomSheet: Container(
        height: 48.0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TiledTimeDisplay(
                dateTime: DateTime.now(),
                flex: 3,
                onTap: () {},
                mode: TiledTimeDisplayMode.StartMode,
              ),
              TiledTimeDisplay(
                dateTime:
                    null, //DateTime.now().add(Duration(minutes: 20, hours: 30, days: 8)),
                flex: 3,
                onTap: () { Future<TimeOfDay> selectedTimeRTL = showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      child: child,
                    );
                  },
                );},
                mode: TiledTimeDisplayMode.InProgressMode,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: 48,
                  height: 48,
                  color: Colors.white,
                ),
              ),
              TiledIconButton(
                onTap: () {},
                iconData: Icons.check,
                flex: 1,
                iconSizeFactor: 1.0,
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 16, bottom: 48),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              prefix: Padding(
                padding: EdgeInsets.only(
                  right: 8,
                  left: 4,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.grey[700],
                  size: 24,
                ),
              ),
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              hintText: "Take an action...",
              hintStyle: TextStyle(fontSize: 22, color: Colors.grey[500]),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 22,
              color: Colors.grey[700],
            ),
            autofocus: true,
            autocorrect: true,
            cursorColor: Colors.grey[400],
            cursorWidth: 2.0,
            enableInteractiveSelection: true,
            minLines: 1,
            maxLines: 4,
            maxLength: 60,
            maxLengthEnforced: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ]),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
