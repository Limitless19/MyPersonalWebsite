import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';

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
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _controller.addListener(() {
      setState(() {
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
        padding:  EdgeInsets.symmetric(horizontal: 2.22 * SizeConfig.widthMultiplier, vertical: 1.25 * SizeConfig.heightMultiplier),
        child: Column(
          children: <Widget>[
            Text(widget.text,style: TextStyle(
              fontSize: 2.35 * SizeConfig.heightMultiplier,
              color: Colours.lightestColor,
            )),
            SizedBox(height: 1.5 * SizeConfig.widthMultiplier),
            Container(
              height:  0.73 * SizeConfig.heightMultiplier,
              width: _controller.value * (12.71 * SizeConfig.widthMultiplier),
              decoration: BoxDecoration(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
