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
  AnimationController _picController;
  AnimationController _openSourceController;
  AnimationController _writingsController;
  AnimationController _builtByController;

  Animation<Color> animation;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  PaletteGenerator palette;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    generatePalette(Images.limitless_icon)
        .then((palette) => this.palette = palette);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );

    _appBarController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    );

    animation =
        ColorTween(begin: Colours.darkestColor, end: Colours.lightestColor)
            .animate(_controller);
    opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_appBarController);

    _controller.addListener(() {
      setState(() {});
    });

    _appBarController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _appBarController.dispose();
    _helloController.dispose();
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
              (190 * SizeConfig.heightMultiplier)) {
            defaultBloc.defaultSink(true);
          } else {
            defaultBloc.defaultSink(false);
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
                  scale: opacityAnimation,
                  child: LimitlessAvatar(),
                ),
                actions: <Widget>[
                  FadeTransition(
                    opacity: opacityAnimation,
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
                    opacity: opacityAnimation,
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
                    opacity: opacityAnimation,
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
                                fontSize: 6.25 * SizeConfig.heightMultiplier,
                                color: animation.value),
                            textAlign: TextAlign.center,
                            alignment: AlignmentDirectional.centerStart),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                FadeTransition(
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
                      Column(
                        children: <Widget>[
                          HeaderWidget(
                            title: 'About me',
                            assetname: Images.about_me_icon,
                            stream: aboutMeBloc.aboutMeStream,
                          ),
                          Container(),
                        ],
                      ),
                      SizedBox(height: 1.56 * SizeConfig.heightMultiplier),
                      FadeTransition(
                            child: BackgroundDymanicText(
                            firstColor: Colours.darkestColor,
                            secondColor: Colours.lightestColor,
                            stream: myDescriptionBloc.myDescriptionStream,
                            text: Strings.about_me_details),
                      ),
                      SizedBox(height: 3.56 * SizeConfig.heightMultiplier),
                      SlideTransition(
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
                  child: HeaderWidget(
                    title: 'Open Source Projects',
                    assetname: Images.os_projects,
                    stream: openSourceProjectsBloc.openSourceProjectsStream,
                  ),
                ),
                SizedBox(height: 4.69 * SizeConfig.heightMultiplier),
                FadeTransition(
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
                      HeaderWidget(
                        assetname: Images.writings,
                        title: 'Writings',
                        stream: defaultBloc.defaultStream,
                      ),
                      SizedBox(height: 3.13 * SizeConfig.heightMultiplier),
                      StreamBuilder(
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
                      SizedBox(height: 7.81 * SizeConfig.heightMultiplier),
                    ],
                  ),
                ),
                SlideTransition(
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
    Duration displayAppBar = Duration(milliseconds: 1500);
    Future.delayed(displayAppBar, () {
      setState(() {
        _appBarController.forward();
      });
    });

    Duration helloMessage = Duration(milliseconds: 2000);
    Future.delayed(helloMessage, () {
      setState(() {
        _helloController.forward();
      });
    });

    Duration infoMessage = Duration(milliseconds: 2500);
    Future.delayed(helloMessage, () {
      setState(() {
        _infoController.forward();
      });
    });
  }
}
