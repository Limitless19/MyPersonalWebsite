import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../data/models/writing.dart';

class TimeDetailsWidget extends StatelessWidget {
  final Writing writing;
  const TimeDetailsWidget({Key key, @required this.writing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        width: 44.44 * SizeConfig.widthMultiplier,
        height: 4.69 * SizeConfig.heightMultiplier,
        color: Colours.lightColor,
        child: Padding(
            padding:  EdgeInsets.only(
                left: 3.33* SizeConfig.widthMultiplier, right: 1.11 * SizeConfig.widthMultiplier, top: 0.63 * SizeConfig.heightMultiplier, bottom: 0.49 * SizeConfig.heightMultiplier),
            child: Center(
              child: Text(
                '${writing.monthYear.toString() ?? 'Feb'} - ${writing.minutesRead.toString() ?? 'nil'} mins',
                style: TextStyle(
                  fontSize: 2.19 * SizeConfig.heightMultiplier,
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
    clippedPath.moveTo(size.width / 13.33, 0);
    clippedPath.lineTo(0, size.height);
    clippedPath.lineTo(size.width, size.height);
    clippedPath.lineTo(size.width, 0);
    clippedPath.close();

    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
