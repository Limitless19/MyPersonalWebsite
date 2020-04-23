import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';

class ProfilePicture extends StatefulWidget {
  final String imageUrl;
  final double radius; 
  const ProfilePicture({
    Key key,
    this.imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/my-personal-website-28fe2.appspot.com/o/limitlessicon.jpg?alt=media&token=f21dea47-ba61-4d3e-9880-63ad44a8c453',
        @required this.radius ,
  }) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, upperBound: 1.0, duration: Duration(milliseconds: 200),lowerBound: 0.4);

    _controller.addListener(() { 
      setState(() {
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
    return InkWell(
      onHover: (_) {
        setState(() {
           if (_controller.status == AnimationStatus.dismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },onTap: (){
        setState(() {
           if (_controller.status == AnimationStatus.dismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      child: Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(_controller.value* (12.5 * SizeConfig.heightMultiplier))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_controller.value * (12.5 * SizeConfig.heightMultiplier))),
        child: Image.network(
          widget.imageUrl,
          height: 32.81 * SizeConfig.heightMultiplier,
          width:  58.33 * SizeConfig.widthMultiplier,
          fit: BoxFit.fitHeight,
        ),
      ),
    ),
    );
  }
}
