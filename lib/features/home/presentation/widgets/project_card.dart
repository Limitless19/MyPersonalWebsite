import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../../../core/constants/colors.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/size_config.dart';
import '../../data/models/project.dart';
import 'app_type_widget.dart';
import 'icon_buttons.dart';


//TODO Build cards for PC and Tab views

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
    });
    _controller.addStatusListener((status) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
              height: (1.88 * SizeConfig.heightMultiplier) -
                  (_controller.value * (1.88 * SizeConfig.heightMultiplier))),
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
              padding: EdgeInsets.symmetric(
                  horizontal: 2.22 * SizeConfig.widthMultiplier),
              child: Container(
                width: 84.33 * SizeConfig.widthMultiplier,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: _controller.value * 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        1.56 * SizeConfig.heightMultiplier),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 42.19 * SizeConfig.heightMultiplier,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 1.25 * SizeConfig.heightMultiplier),
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
                                      forProjectCard: true,
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
                                      forProjectCard: true,
                                      color: Colours.darkestColor,
                                      hoverColor: Colours.lightColor,
                                    ),
                                  ],
                                ),
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
                                    SizedBox(
                                        height:
                                            1.56 * SizeConfig.heightMultiplier),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 4.44 *
                                              SizeConfig.widthMultiplier),
                                      width: 41.18 * SizeConfig.widthMultiplier,
                                      height:
                                          18.75 * SizeConfig.heightMultiplier,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Text(
                                          widget.project.shortDescription,
                                          style: TextStyle(
                                            color: Colours.darkestColor,
                                            fontSize: 2.19 *
                                                SizeConfig.textMultiplier,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 3.33 * SizeConfig.widthMultiplier,
                                      right: 3.33 * SizeConfig.widthMultiplier,
                                      top: 1.56 * SizeConfig.heightMultiplier),
                                  child: Image.network(
                                    widget.project.imagePath,
                                    height: 17.19 * SizeConfig.heightMultiplier,
                                    width: 33.33 * SizeConfig.widthMultiplier,
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
        width: 38.24 * SizeConfig.widthMultiplier,
        child: Padding(
          padding: EdgeInsets.only(left: 2.22 * SizeConfig.widthMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
              SizedBox(height: 0.63 * SizeConfig.heightMultiplier),
              Container(
                height: 0.78 * SizeConfig.heightMultiplier,
                width: title.length * 10.0,
                decoration: BoxDecoration(
                  color: Colours.darkColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
