import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/limitless_avatar.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/placeholder/placeholder_image_with_text.dart';
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

    generatePalette(Images.limitless_icon)
        .then((palette) => this.palette = palette);

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
    return  CustomScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
            floating: true,
            expandedHeight: SizeConfig.heightMultiplier * 10,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
         //   leading: LimitlessAvatar(),
            actions: <Widget>[
              ActionWidget(
                text: 'About Me',
                onTapped: () {
                  Scrollable.ensureVisible(about_me_key.currentContext,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
              ),
              ActionWidget(
                text: 'Projects',
                onTapped: () {
                  Scrollable.ensureVisible(projects_key.currentContext,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
                },
              ),
              ActionWidget(
                text: 'Writings',
                onTapped: () {
                  Scrollable.ensureVisible(writings_key.currentContext,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeIn);
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
                    style: TextStyle(color: Colours.lightestColor, fontSize:3.44 *SizeConfig.heightMultiplier)),
                Padding(
                  padding: EdgeInsets.only(
                      top: 14 * SizeConfig.heightMultiplier,
                      bottom: 4 *  SizeConfig.heightMultiplier,
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RotateAnimatedTextKit(
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
                              fontSize: 6.25 * SizeConfig.heightMultiplier,
                              fontFamily: "Horizon",
                              color: Colours.darkestColor),
                          textAlign: TextAlign.center,
                          alignment: AlignmentDirectional.centerStart),
                    ],
                  ),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listIconButtons),
            SizedBox(height: 16.44 * SizeConfig.heightMultiplier),
            Padding(
              padding: EdgeInsets.only(left: 4.17 * SizeConfig.widthMultiplier),
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
                  SizedBox(height: 1.56 * SizeConfig.heightMultiplier),
                  Text(Strings.about_me_details),
                  ProfilePicture(radius: 18.75 * SizeConfig.heightMultiplier),
                ],
              ),
            ),
            SizedBox(height: 23.44 * SizeConfig.heightMultiplier),
            Padding(
              padding: EdgeInsets.only(left: 4.17 * SizeConfig.widthMultiplier),
              child: HeaderWidget(
                key: projects_key,
                title: 'Open Source Projects',
                assetname: Images.os_projects,
              ),
            ),
            SizedBox(height: 4.69 * SizeConfig.heightMultiplier),
            FadeTransition(
              opacity: animation,
              child: StreamBuilder(
                  stream: firestore.collection('Projects').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: listPlaceholder,
                      );
                    }
                    return _buildProjectsListFromFirebase(
                        context, snapshot.data.documents);
                  }),
            ),
            SizedBox(height: 9.38 * SizeConfig.heightMultiplier),
            Padding(
              padding: EdgeInsets.only(left: 4.17 * SizeConfig.widthMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  HeaderWidget(
                    key: writings_key,
                    assetname: Images.writings,
                    title: 'Writings',
                  ),
                  SizedBox(height: 3.13 * SizeConfig.heightMultiplier),
                  FadeTransition(
                    opacity: animation,
                    child: StreamBuilder(
                        stream: firestore.collection('Writings').snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: listPlaceholder,
                            );
                          }
                          return _buildWritingsListFromFirebase(
                              context, snapshot.data.documents);
                        }),
                  ),
                  SizedBox(height: 7.81 * SizeConfig.heightMultiplier),
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
      height: 46.88 * SizeConfig.heightMultiplier,
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
      height: 46.88 * SizeConfig.heightMultiplier,
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
