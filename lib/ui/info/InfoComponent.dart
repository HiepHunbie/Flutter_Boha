import 'dart:async';

import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:boha/ui/splash/SplashPresenter.dart';
import 'package:boha/ui/list/ListComponent.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../app_localizations.dart';
import 'InfoPresenter.dart';
import 'InfoView.dart';

class InfoPageState extends State<InfoPage> implements InfoView {

  BasicInfoPresenter presenter;

  InfoPageState() {
    presenter = new BasicInfoPresenter(this);
  }

  void navigationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      appBar:  EmptyAppBar (),
      body: new Container(
          child: Stack(
              children: <Widget>[
                Align(alignment: Alignment.topCenter,
                  child: new Column(
                    children: <Widget>[
                      _titleTop(),
                      _listScroll(),
                    ],
                  ),),
              ]
          )
      ),
    );
  }

  Widget _shareApp(){
    return new Container(
      child: new Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container( height: 50,margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.share,color: Color(TEXT_MAIN),size: 30,),),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).translate('share_app'),
                        style: TextStyle(color: Color(TEXT_TITLE), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),
                    Text(AppLocalizations.of(context).translate('share_with_friends'),
                        style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.normal,)),

                  ],
                ),)

            ],
          ),
          Container( height: 50,alignment: Alignment.centerRight,
            child: Icon(Icons.navigate_next,color: Colors.grey,size: 20,),)
        ],
      ),
    );
  }
  Widget _voteApp(){
    return new Container(
      child: new Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container( height: 50,margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.star,color: Color(TEXT_MAIN),size: 30,),),
              Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).translate('vote_app'),
                        style: TextStyle(color: Color(TEXT_TITLE), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),
                    Text(AppLocalizations.of(context).translate('vote_5_star'),
                        style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.normal,)),
                  ],
                ),)

            ],
          ),
          Container( height: 50,alignment: Alignment.centerRight,
            child: Icon(Icons.navigate_next,color: Colors.grey,size: 20,),)
        ],
      ),
    );
  }
  Widget _teamBuildApp(){

    return new GestureDetector(
        onTap: () => _launchURL(),
        child:new Container(
          child: new Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container( height: 50,margin: EdgeInsets.only(right: 10),
                    child: Icon(Icons.language,color: Color(TEXT_MAIN),size: 30,),),
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate('lts_sf'),
                            style: TextStyle(color: Color(TEXT_TITLE), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),
                        Text(AppLocalizations.of(context).translate('go_to_website'),
                            style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.normal,)),

                      ],
                    ),)

                ],
              ),
              Container( height: 50,alignment: Alignment.centerRight,
                child: Icon(Icons.navigate_next,color: Colors.grey,size: 20,),)
            ],
          ),
        ));
  }

  Widget _listScroll(){
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('introduce_all'),
                  style: TextStyle(color: Color(TEXT_GRAY), fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),
            ),
            new Stack(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).translate('building'),
                      style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),),
                Align(alignment: Alignment.centerRight,
                  child: Text(AppLocalizations.of(context).translate('lts_sf'),
                      style: TextStyle(color: Color(TEXT_MAIN), fontSize: 16, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: const MySeparator(color: Colors.grey),
            ),
            new Stack(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context).translate('contact'),
                      style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),),
                Align(alignment: Alignment.centerRight,
                  child: Text("luongnh.lts@gmail.com",
                      style: TextStyle(color: Color(TEXT_MAIN), fontSize: 16, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top : 20,bottom: 10),
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('useful'),
                  style: TextStyle(color: Color(TEXT_GRAY), fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),
            ),
            _shareApp(),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: const MySeparator(color: Colors.grey),
            ),
            _voteApp(),
            Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: const MySeparator(color: Colors.grey),
            ),
            _teamBuildApp()
          ],
        ),),
    ) ;
  }
  Widget _titleTop(){
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 8,bottom: 8),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: "Navigation Menu",
            onPressed: ()=> Navigator.pop(context),
          ),
          Expanded(
              child: Align(alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context).translate('about_boha'),style: new TextStyle( fontSize: 18, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold),)
              )),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://lts-software.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InfoPageState();
  }
}