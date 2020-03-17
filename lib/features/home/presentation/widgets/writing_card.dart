import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/error/exceptions.dart';
import 'package:mypersonalwebsite/features/home/data/models/writing.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'time_details_widget.dart';

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
      setState(() {});
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
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: _controller.value * 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.writing.title,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    height: 5,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0.0),
                                ),
                                image: DecorationImage(
                                  image: Image.network(widget.writing.imagePath)
                                      .image,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0,left:5.0,right:5),
                            child: Container(
                              height: 60,
                              child: Text(
                                widget.writing.shortDescription,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: TimeDetailsWidget(writing: widget.writing),
                      )
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
