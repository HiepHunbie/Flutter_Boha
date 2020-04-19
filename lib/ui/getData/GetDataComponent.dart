import 'dart:async';

import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/getData/GetDataInput.dart';
import 'package:boha/model/getData/GetDataResult.dart';
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
  String _yourShop = "";
  int _radioValue1 = -1;
  bool _isLoading = false;
  BasicGetDataPresenter presenter;

  GetDataPageState() {
    presenter = new BasicGetDataPresenter(this);
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
                  ),),
                _isLoading ? new Container(
                  alignment: Alignment.center,
                  color: Color(BACK_TRANS_LOADING),
                  width: double.infinity,
                  height: double.infinity,
                  child: new CircularProgressIndicator(),
                )
                    : new Container(),
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
            new Container(
              margin: EdgeInsets.only(bottom: 15,top: 5),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('phone'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('phone_hint_data'),
                  hintStyle: TextStyle(
                      color: Color(BORDER_SEARCH),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.normal
                  ),
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
            new Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('name'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('name_hint'),
                  hintStyle: TextStyle(
                      color: Color(BORDER_SEARCH),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.normal
                  ),
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
            new Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('your_email'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('your_email_hint'),
                  hintStyle: TextStyle(
                      color: Color(BORDER_SEARCH),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.normal
                  ),
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
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
              margin: EdgeInsets.only(bottom: 15),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('your_shop'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('your_shop_hint'),
                  hintStyle: TextStyle(
                      color: Color(BORDER_SEARCH),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.normal
                  ),
                  border:  OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(BORDER_SEARCH)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                textAlign: TextAlign.left,
                autofocus: false,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onChanged: (text) {
                  setState((){
                    this._yourShop = text;
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
      height: 48,
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child:new Row(
        children: <Widget>[
          new Expanded(child: ButtonTheme(
              minWidth: 200.0,
              height: 48.0,
              child: new RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text(AppLocalizations.of(context).translate('get_data')),
                onPressed: () => _getDataInfo(),
              ))),
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
  void _getDataInfo(){
    GetDataInput getDataInput = new GetDataInput();
    getDataInput.owner = this._name_or_fb.trim();
    getDataInput.phone = this._phone.trim();
    getDataInput.email = this._address.trim();
    getDataInput.name = this._yourShop.trim();
    setState(() {
      _isLoading = true;
    });
    presenter.getDataInfo(getDataInput);
  }
  @override
  void onError(String items) {
    setState(() {
      _isLoading = false;
    });
    _showAlertError(context,items);
  }
  void _showAlertError(BuildContext context, String value) {

    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Error"),
              content: Text(value.trim()),
            )
    );
  }
  @override
  void onSuccess(GetDataResult items) {
    setState(() {
      _isLoading = false;
    });
    navigationPage();
  }
}
class GetDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new GetDataPageState();
  }
}