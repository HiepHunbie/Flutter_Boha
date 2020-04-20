import 'dart:async';

import 'package:boha/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:boha/ui/splash/SplashView.dart';
import 'package:boha/ui/splash/SplashPresenter.dart';
import 'package:boha/ui/list/ListComponent.dart';
import 'package:flutter_svg/svg.dart';
import '../../app_localizations.dart';

class SplashPageState extends State<SpashPage> implements SplashView {

  BasicSplashPresenter presenter;

  SplashPageState() {
    presenter = new BasicSplashPresenter(this);
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ListPage()),
            (Route<dynamic> route) => false
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: Stack(
              children: [
                new Align(alignment: Alignment.topCenter,
                    child: new Container(
                        margin: EdgeInsets.only(top: 200),
                        child: Container(
                          margin: EdgeInsets.only(right: 0),
                          child: SvgPicture.asset("images/ic_logo.svg",
                            color: Color(TEXT_TITLE),),
                        ))),
                new Align(alignment: Alignment.bottomCenter,
                  child: new Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Text(AppLocalizations.of(context).translate('detail_app_splash'),
                        style: TextStyle(color: Color(TEXT_MAIN), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.normal)),
                  ),)
              ]
          )
      ),
    );
  }

}
class SpashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashPageState();
  }
}