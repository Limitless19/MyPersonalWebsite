import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/error/exceptions.dart';
import 'package:mypersonalwebsite/features/home/data/models/writing.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:mypersonalwebsite/features/home/data/models/project.dart';

class WritingCard extends StatefulWidget {
  final Writing writing;

  const WritingCard({Key key, @required this.writing}) : super(key: key);

  @override
  _WritingCardState createState() => _WritingCardState();
}

class _WritingCardState extends State<WritingCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 800),
        upperBound: 1.0,
        lowerBound: 0.0);

    _controller.addListener(() {
      setState(() {
        
      });
      print(_controller.value);
    });
    _controller.addStatusListener((status) {
        print(status);    
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 12.0 - (_controller.value * 12.0)),
          InkWell(
            onTap: () async {
              String url = widget.writing.linkUrl;
              if (url.contains('http')) {
                if (await launcher.canLaunch(url)) {
                  launcher.launch(url);
                } else {
                  throw UrlLaunchException();
                }
              } else {
                 throw InvalidUrlException();
              }
              setState(() {
                if (_controller.status != AnimationStatus.completed) {
                  _controller.animateTo(1.0, curve: Curves.easeIn);
                } else {
                  _controller.animateBack(0.0, curve: Curves.easeIn);
                }
              });
            },
            onHover: (isHovering) {
              setState(() {
                if (isHovering == true) {
                  _controller.animateTo(1.0, curve: Curves.easeIn);
                } else {
                  _controller.animateBack(0.0, curve: Curves.easeIn);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 250,
                child: Card(
                  elevation: _controller.value * 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                                image: DecorationImage(
                                  image: Image.network(widget.writing.imagePath)
                                      .image,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.writing.title,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      widget.writing.shortDescription,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Flutter",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PWritingCard extends StatelessWidget {
  final Writing writing;
  const PWritingCard({Key key,@required this.writing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
      elevation: 8.0,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'hfhehjehjhef  fhewheijodwjjjeeieieo jkejejeu eiehii fnekehi hgeiid fjejoj gjoejoeo gejjeo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.blue),
                      ),
                    ],
                  ),
                  Expanded(flex: 1, child: SizedBox()),
                ],
              ),
              Image.network(
                'https://firebasestorage.googleapis.com/v0/b/my-personal-website-28fe2.appspot.com/o/limitlessicon.jpg?alt=media&token=f21dea47-ba61-4d3e-9880-63ad44a8c453',
                width: double.infinity,
                height: 50,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 10),
              Text(
                'jfjej fjjfj jfjwjfw jfjwfw jeen dhjw jfjfwjw fjkwk fjwkjfw fjfwkjfkw fjwkq fjknfwknfwn  fnfnfwnf fnfkkqnfnf fnfwnnf qnfnf',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        Positioned(
          right: 0,
          bottom: 20,
          child: Container(
            decoration: BoxDecoration(),
            child: WritingCardWidegt(writing: writing),
          ),
        ),
        ],
      ),
    );
  }
}


class WritingCardWidegt extends StatelessWidget {
  Writing writing;
  WritingCardWidegt({Key key,this.writing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation:20.0,
      shape: CustomShapeBorder(),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 18.0, right: 16.0, bottom: 10.0),
          child: Text(
            writing.title,
          ),
        ),
    );
  }
}


class CustomShapeBorder extends ShapeBorder {
  final double distanceFromWall = 12;
  final double controlPointDistanceFromWall = 2;

  Path getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.moveTo(0 + distanceFromWall, 0);
    clippedPath.quadraticBezierTo(controlPointDistanceFromWall,
        controlPointDistanceFromWall, 0, distanceFromWall);
    clippedPath.lineTo(0, size.height - distanceFromWall);
    clippedPath.quadraticBezierTo(
        controlPointDistanceFromWall,
        size.height - controlPointDistanceFromWall,
        0 + distanceFromWall,
        size.height);
    clippedPath.lineTo(size.width - distanceFromWall, size.height);
    clippedPath.quadraticBezierTo(
        size.width - controlPointDistanceFromWall,
        size.height - controlPointDistanceFromWall,
        size.width,
        size.height - distanceFromWall);
    clippedPath.lineTo(size.width, size.height * 0.6);
    clippedPath.quadraticBezierTo(
        size.width - 1,
        size.height * 0.6 - distanceFromWall,
        size.width - distanceFromWall,
        size.height * 0.6 - distanceFromWall - 3);
    clippedPath.lineTo(distanceFromWall + 6, 0);
    clippedPath.close();
    return clippedPath;
  }

  @override
  EdgeInsetsGeometry get dimensions => null;

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return null;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    //*return the getClip method here with the required size first.
    return getClip(Size(120.0, 55.0));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
