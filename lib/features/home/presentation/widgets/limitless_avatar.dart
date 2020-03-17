import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/images.dart';
import 'package:mypersonalwebsite/core/util/sizeconfig.dart';

class LimitlessAvatar extends StatefulWidget {
  const LimitlessAvatar({
    Key key,
  }) : super(key: key);


  @override
  _LimitlessAvatarState createState() => _LimitlessAvatarState();
}

class _LimitlessAvatarState extends State<LimitlessAvatar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), upperBound: 1.0);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      });
    });

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(13.89 * SizeConfig.widthMultiplier),
          gradient: LinearGradient(colors: [
            Colors.yellowAccent.shade200,
            Colors.brown.shade300,
          ]),
          border: Border.all(width: 2.0, color: Colors.transparent)),
      child: Padding(
        padding: EdgeInsets.all(_controller.value * 1.25 * SizeConfig.heightMultiplier),
        child: Container(
          //TODO GIVE HEIGHT AND WIDTH FOR RESPONSIVENESS
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(13.89 * SizeConfig.widthMultiplier),
              border: Border.all(width: 2.0, color: Colors.white)),
          child: CircleAvatar(
            radius: 16.25 * SizeConfig.heightMultiplier,
            backgroundImage: Image.asset(Images.limitless_icon).image,
          ),
        ),
      ),
    );
  }
}
