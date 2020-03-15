import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/images.dart';
import 'package:mypersonalwebsite/core/constants/strings.dart';
import 'package:mypersonalwebsite/core/presentation/widgets/appbackground.dart';
import 'package:mypersonalwebsite/core/util/sizeconfig.dart';
import 'package:mypersonalwebsite/features/home/data/models/project.dart';
import 'package:mypersonalwebsite/features/home/data/models/writing.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/action_widget.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/built_by.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/header_widget.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/icon_buttons.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/projectcard.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/writing_card.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatelessWidget {
  static const id = 'myhomepage route';
  final aboutMeKey = GlobalKey();
  final projectskey = GlobalKey();
  final writingsKey = GlobalKey();

  //ScrollController _scrollController = ScrollController();
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            AppBackground(
                firstCircleColor: Colors.deepPurple,
                secondCircleColor: Colors.purple,
                thirdCircleColor: Colors.purpleAccent),
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
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverAppBar(
            floating: true,
            expandedHeight: SizeConfig.heightMultiplier * 10,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    border: Border.all(width: 2.0, color: Colors.white)),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/my-personal-website-28fe2.appspot.com/o/limitlessicon.jpg?alt=media&token=f21dea47-ba61-4d3e-9880-63ad44a8c453')
                      .image,
                ),
              ),
            ),
            actions: <Widget>[
              ActionWidget(
                text: 'About Me',
                onTapped: () {
                  // Scrollable.ensureVisible(widget.aboutMeKey.currentContext,
                  //     duration: Duration(milliseconds: 1000),
                  //     curve: Curves.easeInOut);
                },
              ),
              ActionWidget(
                text: 'Projects',
                onTapped: () {
                  // Scrollable.ensureVisible(widget.projectskey.currentContext,
                  //     duration: Duration(milliseconds: 1000),
                  //     curve: Curves.easeInOut);
                },
              ),
              ActionWidget(
                text: 'Writings',
                onTapped: () {
                  // Scrollable.ensureVisible(widget.writingsKey.currentContext,
                  //     duration: Duration(milliseconds: 1000),
                  //     curve: Curves.easeInOut);
                },
              ),
            ]),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Hi,I am Limitless!'),
                Padding(
                  padding:
                      EdgeInsets.only(left: SizeConfig.widthMultiplier * 30),
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
                      textStyle:
                          TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
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
                        title: 'About me',
                        assetname: Images.about_me_icon,
                      ),
                      Container(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(Strings.about_me_details),
                  //
                  Container(
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/my-personal-website-28fe2.appspot.com/o/limitlessicon.jpg?alt=media&token=f21dea47-ba61-4d3e-9880-63ad44a8c453'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 150),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: HeaderWidget(
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
      height: 250,
      width: 100,
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
      height: 250,
      width: 100,
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
