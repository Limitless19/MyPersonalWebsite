import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/utils/responsive_widget.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/layouts/landscape_layout.dart';
import 'package:mypersonalwebsite/features/home/presentation/widgets/layouts/portrait_layout.dart';

class MyHomePage extends StatelessWidget {
  static const id = 'myhomepage route';
  final aboutMeKey = GlobalKey();
  final projectskey = GlobalKey();
  final writingsKey = GlobalKey();

  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      portraitLayout: PortraitLayout(),
      // landscapeLayout: LandscapeLayout(),
    );
  }
}


