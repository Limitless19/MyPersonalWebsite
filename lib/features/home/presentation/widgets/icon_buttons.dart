import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mypersonalwebsite/features/home/presentation/pages/my_homepage.dart';

final List<Widget> listIconButtons = [
  IconButton(
      icon: Icon(FontAwesomeIcons.github),
      onPressed: () {
        launchURL('https://www.github.com/limitless19');
      },
      tooltip: 'Github'),
  IconButton(
      icon: Icon(FontAwesomeIcons.linkedin),
      onPressed: () {
        launchURL('https://www.linkedin.com/in/tolulope-oke-a64444183');
      },
      tooltip: 'LinkedIn'),
  IconButton(
      icon: Icon(FontAwesomeIcons.medium),
      onPressed: () {
        launchURL('https://medium.com/@oketolulope3');
      },
      tooltip: 'Medium'),
  IconButton(
    icon: Icon(FontAwesomeIcons.envelope),
    onPressed: () {},
    tooltip: 'Contact me',
  ),
  IconButton(
      icon: Icon(FontAwesomeIcons.twitter),
      onPressed: () {
        launchURL('https://twitter.com/iamlimitless19');
      },
      tooltip: 'Twitter'),
];

