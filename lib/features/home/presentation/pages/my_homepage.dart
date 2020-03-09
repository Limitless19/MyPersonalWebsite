import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mypersonalwebsite/core/constants/strings.dart';
import 'package:mypersonalwebsite/core/util/sizeconfig.dart';

class MyHomePage extends StatelessWidget {
  static const id = 'myhomepage route';
  final dataKey = new GlobalKey();
  ScrollController _scrollController = ScrollController();
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
                expandedHeight: 150.0,
                leading: FlutterLogo(size: 24),
                actions: <Widget>[
                  ActionWidget(text: 'About Me',onTapped: (){

                  },),
                  ActionWidget(text: 'Projects',onTapped: (){

                  },),
                  ActionWidget(text: 'Writings',onTapped: (){

                  },),
                ]),
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text('Hi,I am Limitless!'),
                    Padding(
                      padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 30),
                      child: RotateAnimatedTextKit(
                          onTap: () {
                            print("Tap Event");
                          },
                          text: [
                            'NodeJs',
                            'Django',
                            "Android",
                            'Java',
                            "Dart",
                            "Flutter",
                          ],
                          textStyle:
                              TextStyle(fontSize: 40.0, fontFamily: "Horizon"),
                          textAlign: TextAlign.start,
                          alignment: AlignmentDirectional
                              .topStart // or Alignment.topLeft
                          ),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listIconButtons),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('About Me'),
                      SizedBox(height: 10),
                      Text(Strings.about_me_details)
                    ],
                  ),
                ),     
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Widget> listIconButtons = [
  IconButton(icon: Icon(FontAwesomeIcons.github), onPressed: () {}),
  IconButton(icon: Icon(FontAwesomeIcons.linkedin), onPressed: () {}),
  IconButton(icon: Icon(FontAwesomeIcons.medium), onPressed: () {}),
  IconButton(
    icon: Icon(FontAwesomeIcons.envelope),
    onPressed: () {},
    tooltip: 'Contact me',
  ),
  IconButton(icon: Icon(FontAwesomeIcons.twitter), onPressed: () {}),
];

class ActionWidget extends StatelessWidget {
  final String text;
  final Function onTapped;
  const ActionWidget({Key key, @required this.text, this.onTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (_) {},
      onTap: onTapped ?? null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Text(text),
            SizedBox(height: 5),
            Container(
              height: 4,
              width: 15,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
