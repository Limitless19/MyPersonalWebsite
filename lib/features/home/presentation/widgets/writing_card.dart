import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/error/exceptions.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';
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
        duration: Duration(milliseconds: 300),
        upperBound: 1.0,
        lowerBound: 0.0);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.06 * SizeConfig.heightMultiplier,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: (1.88 * SizeConfig.heightMultiplier) - (_controller.value * (1.88 * SizeConfig.heightMultiplier))),
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
              padding:  EdgeInsets.symmetric(horizontal: 2.22 * SizeConfig.widthMultiplier),
              child: Container(
                width: 69.44 * SizeConfig.widthMultiplier,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: _controller.value * 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1.56 * SizeConfig.heightMultiplier),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding:  EdgeInsets.all(1.88 * SizeConfig.heightMultiplier),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.writing.title,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 2.34 * SizeConfig.heightMultiplier,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    height: 0.78 * SizeConfig.heightMultiplier,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      color: Colours.darkColor,
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                            height: 20.31 * SizeConfig.heightMultiplier,
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
                                 EdgeInsets.only(top: 1.88 * SizeConfig.heightMultiplier,left:1.39 * SizeConfig.widthMultiplier,right:1.39 * SizeConfig.widthMultiplier),
                            child: Container(
                              height: 9.38 * SizeConfig.heightMultiplier,
                              child: Text(
                                widget.writing.shortDescription,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 2.19 * SizeConfig.heightMultiplier
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4.50 * SizeConfig.heightMultiplier),
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
