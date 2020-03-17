import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/constants/colors.dart';
import 'package:mypersonalwebsite/core/util/sizeconfig.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String assetname;
  const HeaderWidget({
    Key key,
    @required this.title,
    @required this.assetname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(title),
              SizedBox(width: 1.11 * SizeConfig.widthMultiplier),
              Image.asset(assetname, height: 3.75 * SizeConfig.heightMultiplier, width: 7.05 * SizeConfig.widthMultiplier),
            ],
          ),
          SizedBox(height: 4),
          Container(
            height: 0.78 * SizeConfig.heightMultiplier,
            width: title.length *  1.56 *SizeConfig.heightMultiplier,
            decoration: BoxDecoration(
              color:Colours.darkColor,
            ),
          )
        ],
      ),
    );
  }
}
