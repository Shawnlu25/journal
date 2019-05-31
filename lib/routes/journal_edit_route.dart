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
          TiledIconButton(
              iconData: Icons.more_vert,
              flex: 0,
              iconSizeFactor: 1.0,
              onTap: () {}),
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
      body: Column(children:[TiledTextfield(),]),
      resizeToAvoidBottomInset: true,
    );
  }
}
