import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';

class BackgroundDymanicText extends StatefulWidget {
  final Color firstColor;
  final Color secondColor;
  final String text;
  Stream stream;
  BackgroundDymanicText({
    Key key,
    @required this.firstColor,
    @required this.secondColor, this.text = 'default',
    @required this.stream,
  }) : super(key: key);

  @override
  _BackgroundDymanicTextState createState() => _BackgroundDymanicTextState();
}

class _BackgroundDymanicTextState extends State<BackgroundDymanicText>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      upperBound: 1.0,
    );

    _animation = ColorTween(begin: widget.firstColor, end: widget.secondColor)
        .animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.stream,
      initialData: false,
      builder: (BuildContext context,AsyncSnapshot<bool> snapshot) {
        return Text(
          widget.text,
          style: TextStyle(
            color: snapshot.data == false ? widget.firstColor : widget.secondColor,
            fontSize: 2.20 * SizeConfig.heightMultiplier,
          ),
        );
      }
    );
  }
}
