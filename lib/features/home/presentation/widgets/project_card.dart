import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/error/exceptions.dart';
import 'package:mypersonalwebsite/features/home/data/models/project.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/icon_buttons.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'app_type_widget.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({Key key, @required this.project}) : super(key: key);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 12.0 - (_controller.value * 12.0)),
          InkWell(
            onTap: () async {
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
                width: 300,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: _controller.value * 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 270,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  LinkButton(
                                    iconData: FontAwesomeIcons.github,
                                    onPressed: () {
                                      String url = widget.project.githubUrl;
                                      launchUrl(url);
                                    },
                                    tooltip: 'Source Code',
                                    color: Colours.darkestColor,
                                    hoverColor: Colours.lightColor,
                                  ),
                                  LinkButton(
                                    iconData: Icons.language,
                                    onPressed: () {
                                      String url = widget.project.linkUrl;
                                      launchUrl(url);
                                    },
                                    tooltip: 'Project',
                                    color: Colours.darkestColor,
                                    hoverColor: Colours.lightColor,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Header(title: widget.project.title),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.only(left: 16.0),
                                      width: 140,
                                      height: 120,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(
                                          widget.project.shortDescription,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0, top: 10.0),
                                  child: Image.network(
                                    widget.project.imagePath,
                                    height: 110,
                                    width: 120,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: AppTypeWidget(project: widget.project),
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

  launchUrl(String url) async {
    if (url.contains('http')) {
      if (await launcher.canLaunch(url)) {
        launcher.launch(url);
      } else {
        throw UrlLaunchException();
      }
    } else {
      throw InvalidUrlException();
    }
  }
}

class Header extends StatelessWidget {
  final String title;
  const Header({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: 130,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 4),
              Container(
                height: 5,
                width: title.length * 10.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
