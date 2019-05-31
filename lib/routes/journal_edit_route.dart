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
        actions: <Widget>[
          /*TiledIconButton(
              iconData: Icons.more_vert,
              flex: 0,
              iconSizeFactor: 1.0,
              onTap: () {}),*/
        ],
      ),
      bottomSheet: Container(
        height: 48.0,
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  height: 48.0,
                  width: 48.0,
                ),
              ),
              TiledTextLabel(
                flex: 6,
                text: "0 / 120",
                textStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
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
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              prefix: Padding(padding: EdgeInsets.only(right: 4,), child: Icon(
                Icons.edit,
                color: Colors.grey[700],
                size: 24,
              ),),
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              hintText: "Take an action...",
              hintStyle: TextStyle(fontSize: 24, color: Colors.grey[500]),
              border: InputBorder.none,
            ),
            style: TextStyle(
              fontSize: 24,
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
