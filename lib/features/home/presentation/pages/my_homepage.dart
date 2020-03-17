import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/images.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/presentation/widgets/appbackground.dart';
import '../../../../core/util/palette_generator.dart';
import '../../../../core/util/sizeconfig.dart';
import '../../data/models/project.dart';
import '../../data/models/writing.dart';
import '../widgets/action_widget.dart';
import '../widgets/built_by.dart';
import '../widgets/header_widget.dart';
import '../widgets/icon_buttons.dart';
import '../widgets/picture_widget.dart';
import '../widgets/project_card.dart';
import '../widgets/writing_card.dart';

class MyHomePage extends StatelessWidget {
  static const id = 'myhomepage route';
  final aboutMeKey = GlobalKey();
  final projectskey = GlobalKey();
  final writingsKey = GlobalKey();

  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AppBackground(),
            Content(),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({
    Key key,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _ContentState extends State<Content> with SingleTickerProviderStateMixin {
  final firestore = Firestore.instance;
  AnimationController _controller;
  Animation<double> animation;
  Animation<double> scaleAnimation;
  PaletteGenerator palette;

  ScrollController _scrollController = ScrollController();
  final about_me_key = GlobalKey();
  final projects_key = GlobalKey();
  final writings_key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 5000,
      ),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(_controller);

    _controller.addStatusListener((status) {
      setState(() {});
    });
    _controller.forward();
  }

  playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    generatePalette(Images.limitless_icon)
        .then((palette) => this.palette = palette);
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
            floating: true,
            expandedHeight: SizeConfig.heightMultiplier * 10,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  //color: palette.,
                  border: Border.all(width: 2.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(width: 2.0, color: Colors.white)),
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: Image.asset(Images.limitless_icon).image,
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              ActionWidget(
                text: 'About Me',
                onTapped: () {
                  Scrollable.ensureVisible(about_me_key.currentContext,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOut);
                },
              ),
              ActionWidget(
                text: 'Projects',
                onTapped: () {
                  Scrollable.ensureVisible(projects_key.currentContext,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOut);
                },
              ),
              ActionWidget(
                text: 'Writings',
                onTapped: () {
                  Scrollable.ensureVisible(writings_key.currentContext,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeInOut);
                },
              ),
            ]),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Hi,I am Limitless!',
                    style: TextStyle(color: Colours.lightestColor)),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.widthMultiplier * 30, top: 60),
                  child: RotateAnimatedTextKit(
                      onTap: () {
                        print("Tap Event");
                      },
                      text: [
                        'NodeJs',
                        'Django',
                        "Android",
                        "Flutter",
                      ],
                      textStyle: TextStyle(
                          fontSize: 40.0,
                          fontFamily: "Horizon",
                          color: Colours.darkestColor),
                      textAlign: TextAlign.start,
                      alignment: AlignmentDirectional.topStart),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listIconButtons),
            SizedBox(height: 150),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      HeaderWidget(
                        key: about_me_key,
                        title: 'About me',
                        assetname: Images.about_me_icon,
                      ),
                      Container(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(Strings.about_me_details),
                  ProfilePicture(),
                ],
              ),
            ),
            SizedBox(height: 150),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: HeaderWidget(
                key: projects_key,
                title: 'Open Source Projects',
                assetname: Images.os_projects,
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
              opacity: animation,
              child: StreamBuilder(
                  stream: firestore.collection('Projects').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      default:
                        return _buildProjectsListFromFirebase(
                            context, snapshot.data.documents);
                    }
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderWidget(
                    key: writings_key,
                    assetname: Images.writings,
                    title: 'Writings',
                  ),
                  SizedBox(height: 10),
                  FadeTransition(
                    opacity: animation,
                    child: StreamBuilder(
                        stream: firestore.collection('Writings').snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              return _buildWritingsListFromFirebase(
                                  context, snapshot.data.documents);
                          }
                        }),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 40),
                  BuiltByWidget(),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildProjectsListFromFirebase(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: snapshots.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return ProjectCard(
            project: Project.fromSnapshot(snapshots[index]),
          );
        },
      ),
    );
  }

  Widget _buildWritingsListFromFirebase(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: snapshots.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return WritingCard(
            writing: Writing.fromSnapshot(snapshots[index]),
          );
        },
      ),
    );
  }
}
