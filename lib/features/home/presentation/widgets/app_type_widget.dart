import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';
import 'package:mypersonalwebsite/features/home/data/models/project.dart';

class AppTypeWidget extends StatelessWidget {
  final Project project;
  const AppTypeWidget({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        width: 33.33 * SizeConfig.widthMultiplier,
        height: 4.69 * SizeConfig.heightMultiplier,
        color: Colours.lightColor,
        child: Padding(
            padding:  EdgeInsets.only(
                left: 3.33 * SizeConfig.widthMultiplier, right: 1.2 * SizeConfig.widthMultiplier, top: 0.63 * SizeConfig.heightMultiplier, bottom: 0.47 * SizeConfig.heightMultiplier),
            child: Center(
              child: Text(
                '${project.appType}',
                style: TextStyle(
                  fontSize: 2.19 * SizeConfig.textMultiplier,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.moveTo(size.width/10, 0);
    clippedPath.lineTo(0, size.height);
    clippedPath.lineTo(size.width, size.height);
    clippedPath.lineTo(size.width, 0);
    clippedPath.close();

    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
