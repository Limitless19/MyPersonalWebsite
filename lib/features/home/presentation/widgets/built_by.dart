import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/util/sizeconfig.dart';
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
              flex: 17,
              child: InkWell(
                onTap: () {
                  launchURL(twitterUrl);
                },
                child: Text(
                  'Oke Tolulope (@iamLimitless19)',
                  style: TextStyle(fontSize: 2.5 * SizeConfig.heightMultiplier),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Text(
                'Built with ',
                textAlign: TextAlign.center,
              ),
              FlutterLogo(size: 1.5 * SizeConfig.heightMultiplier),
            ],
          ),
        ),
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
