import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journal/utils/datetime_display.dart';
import 'package:flutter/widgets.dart';

final double tileUnitSize = 48;

class TiledDashboard extends StatefulWidget {
  @override
  _TiledDashboardState createState() => _TiledDashboardState();
}

class _TiledDashboardState extends State<TiledDashboard> {
  double _height = tileUnitSize * 1;

  @override
  @override
  Widget build(BuildContext context) {
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
                      Navigator.pushNamed(context, "/edit", arguments: null);
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

enum TiledTimeDisplayMode { StartMode, EndMode, InProgressMode, Normal }

class TiledTimeDisplay extends StatelessWidget {
  DateTime dateTime;
  int flex;
  VoidCallback onTap;
  TiledTimeDisplayMode mode;
  TiledTimeDisplay(
      {this.dateTime,
      @required this.flex,
      this.onTap,
      this.mode = TiledTimeDisplayMode.Normal});

  Widget _buildTimeDisplay(BuildContext context) {
    Widget widget;
    switch (this.mode) {
      case TiledTimeDisplayMode.StartMode:
        return Row(
          children: <Widget>[
            Container(
              width: tileUnitSize,
              child: Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.grey[600],
              ),
            ),
            Expanded(
              child: Text(
                getDisplayString(this.dateTime),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        );
        break;
      case TiledTimeDisplayMode.EndMode:
      case TiledTimeDisplayMode.InProgressMode:
        return Row(
          children: <Widget>[
            Expanded(
              child: Text(
                getDisplayString(this.dateTime),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              width: tileUnitSize,
              child: Icon(
                Icons.chevron_left,
                size: 24,
                color: Colors.grey[600],
              ),
            ),
          ],
        );
        break;
      default:
        return Center(
          child: Text(
            getDisplayString(this.dateTime),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: tileUnitSize,
        color: Colors.white,
        child: Material(
          elevation: 0.0,
          color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: onTap,
            child: _buildTimeDisplay(context),
          ),
        ),
      ),
    );
  }
}

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.start
                      ? Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey[600],
                        )
                      : null,
                  Text(
                    "${_timestamp.month} / ${_timestamp.day}  ${_timestamp.hour} : ${formatMinute(_timestamp.minute)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  !widget.start
                      ? Icon(Icons.chevron_left,
                          size: 20, color: Colors.grey[600])
                      : null
                ].where((x) => x != null).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//=============== Textfield ===================

typedef void OnChanged(String text);

class TiledTextfield extends StatefulWidget {
  final OnChanged onChanged;
  final String text;

  @override
  TiledTextfield({Key key, this.onChanged, this.text}) : super(key: key);

  @override
  _TiledTextfield createState() => _TiledTextfield();
}

class _TiledTextfield extends State<TiledTextfield> {
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.text);
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
        child: EditableText(
          scrollPadding: EdgeInsets.symmetric(vertical: 56.0),
          // Cursor
          cursorColor: Colors.grey[400],
          backgroundCursorColor: Colors.grey[100],

          // Selection
          enableInteractiveSelection: true,
          selectionColor: Colors.grey[300],
          selectionControls: materialTextSelectionControls,

          // Max Lines
          autofocus: true,
          maxLines: null,
          controller: _controller,
          focusNode: _focusNode,

          onChanged: widget.onChanged,

          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
