import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/background_dynamic_text.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:after_layout/after_layout.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../core/presentation/widgets/appbackground.dart';
import '../../../../../core/utils/palette_generator.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../data/models/project.dart';
import '../../../data/models/writing.dart';
import '../../bloc/home_bloc.dart';
import '../action_widget.dart';
import '../built_by.dart';
import '../header_widget.dart';
import '../icon_buttons.dart';
import '../limitless_avatar.dart';
import '../picture_widget.dart';
import '../placeholder/placeholder_image_with_text.dart';
import '../project_card.dart';
import '../writing_card.dart';

class PortraitLayout extends StatelessWidget {
  const PortraitLayout({
    Key key,
  }) : super(key: key);

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
  if (await launcher.canLaunch(url)) {
    await launcher.launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _ContentState extends State<Content>
    with TickerProviderStateMixin, AfterLayoutMixin<Content> {
  final firestore = Firestore.instance;

//I dont like the idea of having too many controllers,but i can't seem to come up with a better one for now.
//Open to pull requests,thanks.

  AnimationController _controller;
  AnimationController _appBarController;
  AnimationController _helloController;
  AnimationController _infoController;
  AnimationController _aboutMeController;
  AnimationController _linksController;
  AnimationController _avatarController;
  AnimationController _picController;
  AnimationController _openSourceController;
  AnimationController _openSourceBodyController;
  AnimationController _writingsController;
  AnimationController _writingsBodyController;
  AnimationController _builtByController;

  Animation<Color> animation;
  Animation<double> appBarAnimation;
  Animation<double> scaleAnimation;

  Animation<double> helloAnimation;
  Animation<double> avatarAnimation;
  Animation<double> infoAnimation;
  Animation<Offset> linksAnimation;
  Animation<Offset> picsAnimation;
  Animation<Offset> openSourceTopicAnimation;
  Animation<Offset> writingsAnimation;
  Animation<Offset> buitByAnimation;
  Animation<Offset> aboutMeTitleAnimation;
  Animation<double> openSourceBodyAnimation;
  Animation<double> writingsBodyAnimation;

  PaletteGenerator palette;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    generatePalette(Images.limitless_icon)
        .then((palette) => this.palette = palette);

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            setState(() {});
          });

    _appBarController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            setState(() {});
          });
    _helloController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1400))
          ..addListener(() {
            setState(() {});
          });
    _aboutMeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1400))
          ..addListener(() {
            setState(() {});
          });
    _infoController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1100))
          ..addListener(() {
            setState(() {});
          });
    _linksController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1400))
          ..addListener(() {
            setState(() {});
          });
    _avatarController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            setState(() {});
          });

    _picController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addListener(() {
            setState(() {});
          });
    _openSourceController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1400))
          ..addListener(() {
            setState(() {});
          });
    _openSourceBodyController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {});
      });
    _writingsController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1400))
          ..addListener(() {
            setState(() {});
          });
    _writingsBodyController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addListener(() {
            setState(() {});
          });
    _builtByController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600))
          ..addListener(() {
            setState(() {});
          });

    animation =
        ColorTween(begin: Colours.darkestColor, end: Colours.lightestColor)
            .animate(_controller);
    appBarAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_appBarController);
    avatarAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_avatarController);
    helloAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_helloController);
    infoAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_infoController);
    linksAnimation = Tween<Offset>(begin: Offset(0.9, 0), end: Offset(0, 0))
        .animate(_linksController);
    picsAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.05, 0))
        .animate(_picController);
    aboutMeTitleAnimation =
        Tween<Offset>(begin: Offset(-0.4, 0), end: Offset(0, 0))
            .animate(_aboutMeController);
    openSourceTopicAnimation =
        Tween<Offset>(begin: Offset(1.0, 0), end: Offset(0, 0))
            .animate(_openSourceController);
    openSourceBodyAnimation =
        Tween<double>(begin: 0, end: 1).animate(_openSourceBodyController);
    writingsAnimation = Tween<Offset>(begin: Offset(1.0, 0), end: Offset(0, 0))
        .animate(_writingsController);
    writingsBodyAnimation =
        Tween<double>(begin: 0, end: 1).animate(_writingsBodyController);
    buitByAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset(0, 0))
        .animate(_builtByController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _appBarController.dispose();
    _helloController.dispose();
    _linksController.dispose();
    _avatarController.dispose();
    _aboutMeController.dispose();
    _infoController.dispose();
    _picController.dispose();
    _openSourceController.dispose();
    _writingsController.dispose();
    _builtByController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (t) {
        if (t is ScrollUpdateNotification) {
          print(_scrollController.position.pixels);
          if (_scrollController.position.pixels >=
              (18.15 * SizeConfig.heightMultiplier)) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          if (_scrollController.position.pixels >=
              (33.15 * SizeConfig.heightMultiplier)) {
            linkButtonBloc.linkButtonSink(true);
          } else {
            linkButtonBloc.linkButtonSink(false);
          }
          if (_scrollController.position.pixels >=
              (58 * SizeConfig.heightMultiplier)) {
            aboutMeBloc.aboutMeSink(true);
          } else {
            aboutMeBloc.aboutMeSink(false);
          }
          if (_scrollController.position.pixels >=
              (60 * SizeConfig.heightMultiplier)) {
            myDescriptionBloc.myDescriptionSink(true);
          } else {
            myDescriptionBloc.myDescriptionSink(false);
          }
          if (_scrollController.position.pixels >=
              (130 * SizeConfig.heightMultiplier)) {
            openSourceProjectsBloc.openSourceProjectsSink(true);
          } else {
            openSourceProjectsBloc.openSourceProjectsSink(false);
          }
          if (_scrollController.position.pixels >=
              (92.4 * SizeConfig.heightMultiplier)) {
            setState(() {
              _openSourceController
                  .forward()
                  .whenComplete(() => {_openSourceBodyController.forward()});
            });
          }
          if (_scrollController.position.pixels >=
              (190.5 * SizeConfig.heightMultiplier)) {
            defaultBloc.defaultSink(true);
          } else {
            defaultBloc.defaultSink(false);
          }
          if (_scrollController.position.pixels >=
              (160.82 * SizeConfig.heightMultiplier)) {
            setState(() {
              _writingsController
                  .forward()
                  .whenComplete(() => {_writingsBodyController.forward()});
            });
          }
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent -
                  (10 * SizeConfig.heightMultiplier)) {
            _builtByController.forward();
          } else {
            _builtByController.reverse();
          }
        }
        return true;
      },
      child: Scrollbar(
        child: CustomScrollView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
                floating: true,
                expandedHeight: SizeConfig.heightMultiplier * 10,
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                leading: ScaleTransition(
                  scale: avatarAnimation,
                  child: LimitlessAvatar(),
                ),
                actions: <Widget>[
                  FadeTransition(
                    opacity: appBarAnimation,
                    child: ActionWidget(
                      text: 'About Me',
                      onTapped: () {
                        _scrollController.animateTo(
                            48 * SizeConfig.heightMultiplier,
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.ease);
                      },
                    ),
                  ),
                  FadeTransition(
                    opacity: appBarAnimation,
                    child: ActionWidget(
                      text: 'Projects',
                      onTapped: () {
                        _scrollController.animateTo(
                            132 * SizeConfig.heightMultiplier,
                            duration: Duration(milliseconds: 1200),
                            curve: Curves.ease);
                      },
                    ),
                  ),
                  FadeTransition(
                    opacity: appBarAnimation,
                    child: ActionWidget(
                      text: 'Writings',
                      onTapped: () {
                        _scrollController.animateTo(
                            175 * SizeConfig.heightMultiplier,
                            duration: Duration(milliseconds: 1200),
                            curve: Curves.ease);
                      },
                    ),
                  ),
                ]),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FadeTransition(
                      opacity: helloAnimation,
                      child: Text('Hi,I am Limitless!',
                          style: TextStyle(
                              color: Colours.lightestColor,
                              fontSize: 3.44 * SizeConfig.heightMultiplier)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 14 * SizeConfig.heightMultiplier,
                        bottom: 4 * SizeConfig.heightMultiplier,
                      ),
                      child: FadeTransition(
                        opacity: infoAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RotateAnimatedTextKit(
                                onTap: () {},
                                text: [
                                  'NodeJs',
                                  'Django',
                                  "Android",
                                  "Flutter",
                                ],
                                duration: Duration(milliseconds: 14000),
                                textStyle: TextStyle(
                                    fontSize:
                                        6.25 * SizeConfig.heightMultiplier,
                                    color: animation.value),
                                textAlign: TextAlign.center,
                                alignment: AlignmentDirectional.centerStart),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SlideTransition(
                  position: linksAnimation,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: listIconButtons),
                ),
                SizedBox(height: 16.44 * SizeConfig.heightMultiplier),
                Padding(
                  padding:
                      EdgeInsets.only(left: 4.17 * SizeConfig.widthMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SlideTransition(
                        position: aboutMeTitleAnimation,
                        child: HeaderWidget(
                          title: 'About me',
                          assetname: Images.about_me_icon,
                          stream: aboutMeBloc.aboutMeStream,
                        ),
                      ),
                      SizedBox(height: 1.56 * SizeConfig.heightMultiplier),
                      FadeTransition(
                        opacity: infoAnimation,
                        child: BackgroundDymanicText(
                            firstColor: Colours.darkestColor,
                            secondColor: Colours.lightestColor,
                            stream: myDescriptionBloc.myDescriptionStream,
                            text: Strings.about_me_details),
                      ),
                      SizedBox(height: 3.56 * SizeConfig.heightMultiplier),
                      SlideTransition(
                        position: picsAnimation,
                        child: ProfilePicture(
                            radius: 18.75 * SizeConfig.heightMultiplier),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17.44 * SizeConfig.heightMultiplier),
                Padding(
                  padding:
                      EdgeInsets.only(left: 4.17 * SizeConfig.widthMultiplier),
                  child: SlideTransition(
                    position: openSourceTopicAnimation,
                    child: HeaderWidget(
                      title: 'Open Source Projects',
                      assetname: Images.os_projects,
                      stream: openSourceProjectsBloc.openSourceProjectsStream,
                    ),
                  ),
                ),
                SizedBox(height: 4.69 * SizeConfig.heightMultiplier),
                FadeTransition(
                  opacity: openSourceBodyAnimation,
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
                  padding:
                      EdgeInsets.only(left: 4.17 * SizeConfig.widthMultiplier),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SlideTransition(
                        position: writingsAnimation,
                        child: HeaderWidget(
                          assetname: Images.writings,
                          title: 'Writings',
                          stream: defaultBloc.defaultStream,
                        ),
                      ),
                      SizedBox(height: 3.13 * SizeConfig.heightMultiplier),
                      FadeTransition(
                        opacity: writingsBodyAnimation,
                        child: StreamBuilder(
                            stream:
                                firestore.collection('Writings').snapshots(),
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
                    ],
                  ),
                ),
                SlideTransition(
                  position: buitByAnimation,
                  child: BuiltByWidget(),
                ),
              ]),
            ),
          ],
        ),
      ),
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

  @override
  void afterFirstLayout(BuildContext context) {
    Duration displayAppBar = Duration(milliseconds: 700);
    Future.delayed(displayAppBar, () {
      setState(() {
        _appBarController.forward();
      });
    });

    Duration displayLeadingAvatar = Duration(milliseconds: 2400);
    Future.delayed(displayLeadingAvatar, () {
      setState(() {
        _avatarController.forward();
      });
    });

    Duration helloMessage = Duration(milliseconds: 5700);
    Future.delayed(helloMessage, () {
      setState(() {
        _helloController.forward();
      });
    });

    Duration aboutMeTitle = Duration(milliseconds: 3500);
    Future.delayed(aboutMeTitle, () {
      setState(() {
        _aboutMeController.forward();
      });
    });
    Duration infoMessage = Duration(milliseconds: 3800);
    Future.delayed(infoMessage, () {
      setState(() {
        _infoController.forward();
      });
    });

    Duration links = Duration(milliseconds: 4500);
    Future.delayed(links, () {
      setState(() {
        _linksController.forward();
      });
    });
  }
}
