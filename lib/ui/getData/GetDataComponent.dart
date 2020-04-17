import 'dart:async';

import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:boha/ui/splash/SplashPresenter.dart';
import 'package:boha/ui/list/ListComponent.dart';
import '../../app_localizations.dart';
import 'GetDataPresenter.dart';
import 'GetDataView.dart';

class GetDataPageState extends State<GetDataPage> implements GetDataView {

  String _phone = "";
  String _name_or_fb = "";
  String _address = "";
  String _history = "";
  int _radioValue1 = -1;
  BasicGetDataPresenter presenter;

  GetDataPageState() {
    presenter = new BasicGetDataPresenter(this);
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          break;
        case 1:
          break;
      }
    });
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
    setState(() {
      _radioValue1 = 0;
    });
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
                Align(alignment: Alignment.bottomCenter,
                  child: new Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 10),
                    child: _buttonSend(),
                  ),)
              ]
          )
      ),
    );
  }

  Widget _listScroll(){
    return new Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('phone'),
                  style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),
            ),
            new Container(
              margin: EdgeInsets.only(bottom: 5),
              height: 40,
              child: new TextFormField(
                decoration:  new InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(TEXT_MAIN),
                      fontSize: 14.0,
                    ),
                    hintText: AppLocalizations.of(context).translate('phone_hint'),
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none
                ),
                textAlign: TextAlign.left,
                autofocus: false,
                keyboardType: TextInputType.phone,
                autocorrect: false,
                onChanged: (text) {
                  setState((){
                    this._phone = text;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8,bottom: 10),
              child: const MySeparator(color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('name'),
                  style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),
            ),
            new Container(
              margin: EdgeInsets.only(bottom: 5),
              height: 40,
              child: new TextFormField(
                decoration:  new InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(TEXT_MAIN),
                      fontSize: 14.0,
                    ),
                    hintText: AppLocalizations.of(context).translate('name_hint'),
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none
                ),
                textAlign: TextAlign.left,
                autofocus: false,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (text) {
                  setState((){
                    this._name_or_fb = text;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8,bottom: 10),
              child: const MySeparator(color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('your_address'),
                  style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),
            ),
            new Container(
              margin: EdgeInsets.only(bottom: 5),
              height: 40,
              child: new TextFormField(
                decoration:  new InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(TEXT_MAIN),
                      fontSize: 14.0,
                    ),
                    hintText: AppLocalizations.of(context).translate('your_address_hint'),
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none
                ),
                textAlign: TextAlign.left,
                autofocus: false,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (text) {
                  setState((){
                    this._address = text;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8,bottom: 10),
              child: const MySeparator(color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('your_shop'),
                  style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Regular',fontWeight: FontWeight.bold,)),
            ),
            new Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 40,
              child: new TextFormField(
                decoration:  new InputDecoration(
                    labelStyle: TextStyle(
                      color: Color(TEXT_MAIN),
                      fontSize: 14.0,
                    ),
                    hintText: AppLocalizations.of(context).translate('your_shop_hint'),
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                    border: InputBorder.none
                ),
                textAlign: TextAlign.left,
                autofocus: false,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (text) {
                  setState((){
                    this._address = text;
                  });
                },
              ),
            ),
            new Container(
              margin: EdgeInsets.only(bottom: 50),
              child: new Text(AppLocalizations.of(context).translate('detail_get_data'),
                style: new TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Montserrat Regular',fontStyle: FontStyle.normal),
              ),
            )
            ,
          ],
        ),),
    ) ;
  }
  Widget _buttonSend(){
    return new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child:new Row(
        children: <Widget>[
          new Expanded(child: new RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: new Text(AppLocalizations.of(context).translate('get_data')),
            onPressed: () {
            },
          )),
        ],
      ) ,
    );
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
                  child: Text(AppLocalizations.of(context).translate('get_data'),style: new TextStyle( fontSize: 18, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold),)
              )),
        ],
      ),
    );
  }
}
class GetDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GetDataPageState();
  }
}