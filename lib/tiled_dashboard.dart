import 'package:flutter/material.dart';

final double tileUnitSize = 48;

class TiledDashboard extends StatefulWidget {
  @override
  _TiledDashboardState createState() => _TiledDashboardState();
}

class _TiledDashboardState extends State<TiledDashboard> {
  double _height = tileUnitSize * 8;

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps
    return AnimatedContainer(
      height: _height,
      duration: Duration(milliseconds: 100),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                TiledTextButton(
                  onTap: () {
                        setState(() {
                          _height = tileUnitSize * 2;
                        });
                      },
                  flex: 7,
                  text: "Take an action...",
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
                TiledIconButton(
                  onTap: () => {},
                  iconData: Icons.more_vert,
                  flex: 1,
                  iconSizeFactor: 1.0,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                TiledTextButton(
                  onTap: () {
                        setState(() {
                          _height = tileUnitSize * 4;
                        });
                      },
                  flex: 5,
                  text: "Take an action...",
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
                TiledTimeButton(),
              ],
            ),
            TiledTextfield(),
          ],
        ),
      ),
    );
  }
}

class TiledTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final int flex;
  final String text;
  final TextStyle textStyle;

  const TiledTextButton(
      {Key key, this.onTap, this.flex, this.text, this.textStyle})
      : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: tileUnitSize,
        color: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Material(
          elevation: 0.0,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: onTap,
            child: Align(
              alignment: FractionalOffset(0.1, 0.5),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TiledIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final int flex;
  final double iconSizeFactor;

  const TiledIconButton(
      {Key key, this.onTap, this.iconData, this.flex, this.iconSizeFactor})
      : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: tileUnitSize,
        color: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Material(
          elevation: 0.0,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.grey[600],
                size: tileUnitSize * iconSizeFactor / 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TiledTimeButton extends StatefulWidget {
  @override
  _TiledTimeButtonState createState() => _TiledTimeButtonState();
}

class _TiledTimeButtonState extends State<TiledTimeButton> {
  DateTime _timestamp = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        height: tileUnitSize,
        color: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Material(
          elevation: 0.0,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: () => {},
            child: Center(
                child: Text(
              "${_timestamp.month} / ${_timestamp.day}  ${_timestamp.hour} : ${_timestamp.minute}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class TiledTextfield extends StatelessWidget {
  const TiledTextfield({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Container(
        height: tileUnitSize * 3,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: EditableText(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          cursorColor: Colors.grey[400],
          backgroundCursorColor: Colors.grey[100],
          maxLines: 3,
        ),
      ),
    );
  }
}
