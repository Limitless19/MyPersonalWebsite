import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 29 * SizeConfig.heightMultiplier,
      ),
      painter: MyCurvesPainter(),
    );
  }
}


class MyCurvesPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint= Paint();

    //third curve
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70, size.width * 0.17, size.height*0.90);
    path.quadraticBezierTo(size.width * 0.20, size.height, size.width * 0.25, size.height*0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40, size.width * 0.50, size.height*0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85, size.width * 0.65, size.height*0.65);
    path.quadraticBezierTo(size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    paint.color = Colours.lightestColor;
    canvas.drawPath(path, paint);

  //reusing the same object for a different instance.
  //second curve.
    path = Path();
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80, size.width * 0.15, size.height*0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45, size.width * 0.27, size.height*0.60);
    path.quadraticBezierTo(size.width * 0.45, size.height, size.width * 0.50, size.height*0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45, size.width * 0.75, size.height*0.75);
    path.quadraticBezierTo(size.width * 0.85, size.height * 0.93, size.width , size.height*0.60);
    path.lineTo(size.width, 0);
    path.close();
   
    paint.color = Colours.darkColor;
    canvas.drawPath(path, paint);

    //first curve.
    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55, size.width * 0.20, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90, size.width * 0.40, size.height*0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50, size.width * 0.65, size.height*0.70);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.85, size.width, size.height*0.60);
    path.lineTo(size.width, 0);
    path.close();

    paint.color = Colours.darkestColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this; //return true for custom clipper.
  }
  
}
