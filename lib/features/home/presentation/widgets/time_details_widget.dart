import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/features/home/data/models/writing.dart';

class TimeDetailsWidget extends StatelessWidget {
  final Writing writing;
  const TimeDetailsWidget({Key key, @required this.writing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        width: 160,
        height: 30,
        color: Colors.blueAccent,
        child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 4.0, top: 4.0, bottom: 3.0),
            child: Center(
              child: Text(
                '${writing.monthYear.toString() ?? 'Feb'} - ${writing.minutesRead.toString() ?? 'nil'} mins',
                style: TextStyle(
                  fontSize: 14,
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
    clippedPath.moveTo(12.0, 0);
    clippedPath.lineTo(0, size.height);
    clippedPath.lineTo(size.width, size.height);
    clippedPath.lineTo(size.width, 0);
    clippedPath.close();

    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
