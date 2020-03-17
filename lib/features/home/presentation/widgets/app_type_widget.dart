import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/features/home/data/models/project.dart';

class AppTypeWidget extends StatelessWidget {
  final Project project;
  const AppTypeWidget({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        width: 120,
        height: 30,
        color: Colors.blueAccent,
        child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 4.0, top: 4.0, bottom: 3.0),
            child: Center(
              child: Text(
                '${project.appType}',
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
