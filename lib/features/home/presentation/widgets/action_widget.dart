import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';

class ActionWidget extends StatefulWidget {
  final String text;
  final Function onTapped;
  const ActionWidget({Key key, @required this.text, this.onTapped})
      : super(key: key);

  @override
  _ActionWidgetState createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _controller.addListener(() {
      setState(() {
        print(_controller.value);
      });
    });

    _controller.addStatusListener((status) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      onHover: (isHovering) {
        setState(() {
          if (_controller.status == AnimationStatus.dismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      splashColor: Colors.transparent,
      onTap: widget.onTapped ?? null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            Text(widget.text,style: TextStyle(
              color: Colours.lightestColor,
            )),
            SizedBox(height: 5),
            Container(
              height: 4,
              width: _controller.value * 50,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
