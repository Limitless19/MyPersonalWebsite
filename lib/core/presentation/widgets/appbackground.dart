import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';

class AppBackground extends StatelessWidget {
 final Color firstCircleColor;
  final Color secondCircleColor;
  final Color thirdCircleColor;

  const AppBackground({Key key,@required this.firstCircleColor,@required this.secondCircleColor,@required this.thirdCircleColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final screenHeight = constraint.maxHeight;
        final screenWidth = constraint.maxWidth;
        return Stack(
          children: <Widget>[
            Container(
              color: Colours.backgroundColor,
            ),
            Positioned(
              left: -(screenHeight - screenWidth) / 2,
              bottom: screenHeight * 0.20,
              child: Container(
                height: screenHeight,
                width: screenHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: firstCircleColor,
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.15,
              top: -screenWidth * 0.5,
              child: Container(
                height: screenWidth * 1.5,
                width: screenWidth * 1.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondCircleColor,
                ),
              ),
            ),
             Positioned(
              right: -screenWidth * 0.2,
              top: -50,
              child: Container(
                height: screenWidth * 0.6,
                width: screenWidth * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: thirdCircleColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

