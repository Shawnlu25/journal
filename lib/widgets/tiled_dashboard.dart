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
                    //color: Colors.grey[500],
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
        //color: Colors.white,
        padding: EdgeInsets.all(0.0),
        child: Material(
          elevation: 0.0,
          //color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, top: 12.0),
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
  final VoidCallback onDoubleTap;
  final IconData iconData;
  final int flex;
  final double iconSizeFactor;

  const TiledIconButton(
      {Key key,
      this.onTap,
      this.iconData,
      this.flex,
      this.iconSizeFactor,
      this.onDoubleTap})
      : super(key: key);

  Widget _buildInnerWidget(BuildContext context) {
    return Container(
      height: tileUnitSize,
      width: flex == 0 ? tileUnitSize : null,
      //color: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Material(
        elevation: 0.0,
        //color: Colors.white,
        animationDuration: Duration(milliseconds: 100),
        child: InkWell(
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          child: Center(
            child: Icon(
              iconData,
              //color: Colors.grey[600],
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
  final String text;
  final int flex;
  final TextStyle textStyle;

  TiledTextLabel({@required this.text, @required this.flex, this.textStyle});

  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: tileUnitSize,
        //color: Colors.white,
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
  final DateTime dateTime;
  final int flex;
  final VoidCallback onTap;
  final TiledTimeDisplayMode mode;
  final VoidCallback onDoubleTap;

  TiledTimeDisplay({
    this.dateTime,
    @required this.flex,
    this.onTap,
    this.onDoubleTap,
    this.mode = TiledTimeDisplayMode.Normal,
  });

  Widget _buildTimeDisplay(BuildContext context) {
    switch (this.mode) {
      case TiledTimeDisplayMode.StartMode:
        return Row(
          children: <Widget>[
            Container(
              width: tileUnitSize,
              child: Icon(
                Icons.chevron_right,
                size: 24,
                //color: Colors.grey[600],
              ),
            ),
            Expanded(
              child: Text(
                getDisplayString(this.dateTime),
                style: TextStyle(
                  fontSize: 16,
                  //color: Colors.grey[600],
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
                  //color: Colors.grey[600],
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              width: tileUnitSize,
              child: Icon(
                Icons.chevron_left,
                size: 24,
                //color: Colors.grey[600],
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
              //color: Colors.grey[600],
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
        //color: Colors.white,
        child: Material(
          elevation: 0.0,
          //color: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          child: InkWell(
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            child: _buildTimeDisplay(context),
          ),
        ),
      ),
    );
  }
}
