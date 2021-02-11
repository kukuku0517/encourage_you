import 'package:encourage_you/MyTheme.dart';
import 'package:flutter/material.dart';

import 'view/ListPage.dart';

void main() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListPage(),
        theme: myTheme,
        title: 'Flutter Demeo',
        routes: {
          // '/signIn': (context) => SignInPage(),
          ListPage.routeName: (context) => ListPage(),
          // DrinkDetailPage.routeName: (context) => DrinkDetailPage(),
          // EpisodeWritePage.routeName: (context) => EpisodeWritePage()
        }));
