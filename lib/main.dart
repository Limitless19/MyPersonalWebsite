import 'package:flutter/material.dart';
import 'package:mypersonalwebsite/core/utils/size_config.dart';
import 'package:provider/provider.dart';

import 'core/themes/appstate.dart';
import 'core/themes/apptheme.dart';
import 'features/home/presentation/pages/my_homepage.dart';

void main() => runApp(
      ChangeNotifierProvider<AppState>(
        child: MyApp(),
        create: (BuildContext context) => AppState(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState appstate, Widget child) {
        return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'Limitless19 Portfolio',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme, //our own custom Themes.
              darkTheme: AppTheme.darkTheme,
              themeMode: appstate.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode
                      .light, //decider of which theme to use-light or dark.
              initialRoute: MyHomePage.id,
              routes: {
                MyHomePage.id: (context) => MyHomePage(),
              },
            );
          });
        });
      },
    );
  }
}
