import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class BuiltByWidget extends StatelessWidget {
  const BuiltByWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String twitterUrl = 'https://twitter.com/iamlimitless19';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 10,
              child: InkWell(
                onTap: () {
                  launchURL(twitterUrl);
                },
                child: Text('Oke Tolulope (@iamLimitless19)'),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        Center(
          child: Row(
            children: <Widget>[
              Text('Built with'),
              FlutterLogo(size: 16),
            ],
          ),
        )
      ],
    );
  }

  launchURL(String url) async {
    if (await launcher.canLaunch(url)) {
      await launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
