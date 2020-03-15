import 'package:flutter/material.dart';

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
              SizedBox(width: 4),
              Image.asset(assetname, height: 24, width: 24),
            ],
          ),
          SizedBox(height: 4),
          Container(
            height: 5,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }
}
