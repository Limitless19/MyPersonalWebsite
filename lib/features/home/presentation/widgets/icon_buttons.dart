import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/util/sizeconfig.dart';
import 'package:mypersonalwebsite/features/home/presentation/pages/my_homepage.dart';

final List<Widget> listIconButtons = [
  LinkButton(
      iconData: FontAwesomeIcons.github,
      color: Colours.darkestColor,
      hoverColor: Colours.darkColor,
      onPressed: () {
        launchURL('https://www.github.com/limitless19');
      },
      tooltip: 'Github'),
  LinkButton(
      iconData: FontAwesomeIcons.linkedin,
      color: Colours.darkestColor,
      hoverColor: Colours.darkColor,
      onPressed: () {
        launchURL('https://www.linkedin.com/in/tolulope-oke-a64444183');
      },
      tooltip: 'LinkedIn'),
  LinkButton(
      iconData: FontAwesomeIcons.medium,
      color: Colours.darkestColor,
      hoverColor: Colours.darkColor,
      onPressed: () {
        launchURL('https://medium.com/@oketolulope3');
      },
      tooltip: 'Medium'),
  LinkButton(
      iconData: FontAwesomeIcons.envelope,
      color: Colours.darkestColor,
      hoverColor: Colours.darkColor,
      onPressed: () {},
      tooltip: 'Contact me'),
  LinkButton(
      iconData: FontAwesomeIcons.twitter,
      color: Colours.darkestColor,
      hoverColor: Colours.darkColor,
      onPressed: () {
        launchURL('https://twitter.com/iamlimitless19');
      },
      tooltip: 'Twitter'),
];

class LinkButton extends StatefulWidget {
  final IconData iconData;
  final Function() onPressed;
  final String tooltip;
  final Color color;
  final Color hoverColor;
  const LinkButton(
      {Key key,
      this.iconData,
      this.onPressed,
      @required this.color,
      @required this.hoverColor,
      @required this.tooltip})
      : super(key: key);

  @override
  _LinkButtonState createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = ColorTween(begin: widget.color, end: widget.hoverColor)
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
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 2.22 * SizeConfig.widthMultiplier),
      child: InkWell(
        onHover: (isHovering) {
          setState(() {
            if (isHovering == true) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          });
        },
        onTap: widget.onPressed,
        child: Tooltip(
          message: widget.tooltip,
          child: Icon(
            widget.iconData,
            color: _animation.value,
            size: 8.24 * SizeConfig.widthMultiplier,
          ),
        ),
      ),
    );
  }
}
