import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/error/exceptions.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:mypersonalwebsite/features/home/data/models/project.dart';

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
      height: 250,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 12.0 - (_controller.value * 12.0)),
          InkWell(
            onTap: () async {
              String url = widget.project.linkUrl;
              if (url.contains('http')) {
                if (await launcher.canLaunch(url)) {
                  launcher.launch(url);
                } else {
                  throw UrlLaunchException();
                }
              } else {
                throw InvalidUrlException();
              }
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
                                  image: Image.network(widget.project.imagePath)
                                      .image,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.project.title,
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
                                      widget.project.shortDescription,
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
