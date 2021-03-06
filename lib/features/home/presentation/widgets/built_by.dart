import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import '../../../../core/utils/size_config.dart';

class BuiltByWidget extends StatelessWidget {
  const BuiltByWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String twitterUrl = 'https://twitter.com/iamlimitless19';
    return Center(
      child: Column(
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
                    style:
                        TextStyle(fontSize: 2.5 * SizeConfig.heightMultiplier),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(flex: 1, child: SizedBox()),
            ],
          ),
           SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: SizedBox(),
              ),
              Expanded(
                flex: 15,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Built with ',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 10),
                    FlutterLogo(),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
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
