import 'package:flutter/material.dart';

import '../../../../core/constants/images.dart';
import '../../../../core/utils/size_config.dart';

class LimitlessAvatar extends StatefulWidget {
  const LimitlessAvatar({
    Key key,
  }) : super(key: key);

  @override
  _LimitlessAvatarState createState() => _LimitlessAvatarState();
}

class _LimitlessAvatarState extends State<LimitlessAvatar>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.25 * SizeConfig.heightMultiplier),
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(19.89 * SizeConfig.widthMultiplier),
            border: Border.all(width: 2.0, color: Colors.white)),
        child: CircleAvatar(
          radius: 19.25 * SizeConfig.heightMultiplier,
          backgroundImage: Image.asset(Images.limitless_icon).image,
        ),
      ),
    );
  }
}
