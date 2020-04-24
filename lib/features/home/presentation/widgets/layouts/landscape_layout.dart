import 'package:flutter/material.dart';

class LandscapeLayout extends StatelessWidget {
  const LandscapeLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO Complete layout? Should I create a new layout specially for tab and pc views?
    return Scaffold(
      body: Center(
        child: Text('Landscape layout'),
      ),
    );
  }
}