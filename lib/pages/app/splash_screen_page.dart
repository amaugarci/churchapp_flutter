import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/models_providers/auth_provider.dart';

import '../../models_providers/bible_provider.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000)).then((value) async {
      Provider.of<AuthProvider>(context, listen: false).init();
      Provider.of<BibleProvider>(context, listen: false).initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Center(child: LoadingBouncingGrid.circle(backgroundColor: Theme.of(context).colorScheme.secondary))],
        ),
      ),
    );
  }
}
