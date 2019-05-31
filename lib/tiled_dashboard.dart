import 'package:flutter/material.dart';

final double tileUnitSize = 48;

class TiledDashboard extends StatefulWidget {
  @override
  _TiledDashboardState createState() => _TiledDashboardState();
}

class _TiledDashboardState extends State<TiledDashboard> {
  double _height = tileUnitSize * 1;
  bool _opened = false;

  @override
  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps
    if (!_opened) {
      return Container(
        height: _height,
        //duration: Duration(milliseconds: 100),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  TiledTextButton(
                    onTap: () {
                      setState(() {
                        _opened = true;
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
                    onTap: () {},
                    iconData: Icons.more_vert,
                    flex: 1,
                    iconSizeFactor: 1.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: _height,
        // duration: Duration(milliseconds: 100),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TiledTimeButton(
                    start: true,
                  ),
                  TiledTimeButton(
                    start: false,
                  ),
                  TiledIconButton(
                    onTap: () {
                      this.setState(() {
                        _height = tileUnitSize * 1;
                        _opened = false;
                      });
                    },
                    iconData: Icons.check,
                    flex: 1,
                    iconSizeFactor: 1.0,
                  ),
                  TiledIconButton(
                    onTap: () {},
                    iconData: Icons.more_vert,
                    flex: 1,
                    iconSizeFactor: 1.0,
                  )
                ],
              ),
              Row(
                children: <Widget>[TiledTextfield()],
              )
            ],
          ),
        ),
      );
    }
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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

  Widget _buildInnerWidget(BuildContext context) {
    return Container(
      height: tileUnitSize,
      width: flex == 0 ? tileUnitSize : null,
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
    );
  }

  Widget build(BuildContext context) {
    if (flex == 0) {
      return _buildInnerWidget(context);
    }
    return Expanded(
      flex: flex,
      child: _buildInnerWidget(context),
    );
  }
}

// ============== Text Label ==================
class TiledTextLabel extends StatelessWidget {
  String text;
  int flex;
  TextStyle textStyle;

  TiledTextLabel({@required this.text, @required this.flex, this.textStyle});

  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: tileUnitSize,
        color: Colors.white,
        child: Center(
          child: Text(
            text,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

// ================ Time Button ==================

class TiledTimeButton extends StatefulWidget {
  final bool start;
  TiledTimeButton({@required this.start});

  @override
  _TiledTimeButtonState createState() => _TiledTimeButtonState();
}

class _TiledTimeButtonState extends State<TiledTimeButton> {
  DateTime _timestamp = DateTime.now();

  String formatMinute(int minute) {
    if (minute.toString().length <= 1) {
      return "0" + minute.toString();
    } else {
      return minute.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        height: tileUnitSize,
        color: Colors.white,
        child: Material(
          elevation: 0.0,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: () => {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${widget.start ? "> " : ""}${_timestamp.month} / ${_timestamp.day}  ${_timestamp.hour} : ${formatMinute(_timestamp.minute)}${!widget.start ? " <" : ""}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//=============== Textfield ===================

class TiledTextfield extends StatefulWidget {
  @override
  _TiledTextfield createState() => _TiledTextfield();
}

class _TiledTextfield extends State<TiledTextfield> {
  String _note = "";
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Container(
        height: tileUnitSize * 1,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: <Widget>[
            (_note.length > 0
                ? Container()
                : Text("Take an action...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ))),
            EditableText(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (String note) {
                setState(() {
                  this._note = note;
                });
              },
              autofocus: true,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              cursorColor: Colors.grey[400],
              backgroundCursorColor: Colors.grey[100],
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
