import 'dart:async';

import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/addBohaer/AddBohaerInput.dart';
import 'package:boha/model/addBohaer/AddBohaerResult.dart';
import 'package:boha/utils/Colors.dart';
import 'package:boha/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:boha/ui/splash/SplashPresenter.dart';
import 'package:boha/ui/list/ListComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_localizations.dart';
import 'AddBohaerPresenter.dart';
import 'AddBohaerView.dart';

class AddBohaerPageState extends State<AddBohaerPage> implements AddBohaerView {

  String _phone = "";
  String _name_or_fb = "";
  String _address = "";
  String _history = "";
  int _type=1;
  int _radioValue1 = -1;
  String _userId = "";
  BasicAddBohaerPresenter presenter;
  bool _isLoading;

  AddBohaerPageState() {
    presenter = new BasicAddBohaerPresenter(this);
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          setState(() {
            _type = 1;
          });
          break;
        case 1:
          setState(() {
            _type = 2;
          });
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
    _isLoading = false;
    setState(() {
      _radioValue1 = 0;
    });
    _getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      appBar:  EmptyAppBar (),
      body:  new Container(
          child: Stack(
              children: <Widget>[
                Align(alignment: Alignment.topCenter,
                  child: new Column(
                    children: <Widget>[
                      _titleTop(),
                      _radioChoice(),
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

  Widget _radioChoice(){
    return new Container(
      color: Colors.white,
      child:
      new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(AppLocalizations.of(context).translate('choise_add'),
              style: TextStyle(color: Color(BLACK),fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.normal)),
          new Radio(
            value: 0,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
          new Text(AppLocalizations.of(context).translate('boha'),
              style: TextStyle(color: _radioValue1==0? Color(TEXT_MAIN):Color(BLACK),fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.normal)),
          new Radio(
            value: 1,
            groupValue: _radioValue1,
            onChanged: _handleRadioValueChange1,
          ),
          new Text(AppLocalizations.of(context).translate('cheat'),
              style: TextStyle(color: _radioValue1==1? Color(TEXT_MAIN):Color(BLACK),fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.normal)),
        ],
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
              margin: EdgeInsets.only(bottom: 12,top: 5),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('phone'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0,fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('phone_hint'),
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
              margin: EdgeInsets.only(bottom: 12),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('facebook_or_name'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0, fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('facebook_or_name_hint'),
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
              margin: EdgeInsets.only(bottom: 12),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('address'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0, fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: AppLocalizations.of(context).translate('address_hint'),
                  hintStyle: TextStyle(
                      color: Color(BORDER_SEARCH),
                      fontSize: 14.0, fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.normal
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
              margin: EdgeInsets.only(bottom: 12),
              height: 48,
              child: new TextFormField(
                decoration:  new InputDecoration(
                  labelText: AppLocalizations.of(context).translate('history'),
                  labelStyle: TextStyle(
                      color: Color(TEXT_TITLE),
                      fontSize: 14.0, fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.bold
                  ),
                  hintText: _radioValue1==0? AppLocalizations.of(context).translate('history_hint'):AppLocalizations.of(context).translate('history_hint_cheat'),
                  hintStyle: TextStyle(
                      color: Color(BORDER_SEARCH),
                      fontSize: 14.0, fontFamily: 'Montserrat SemiBold',fontWeight: FontWeight.normal
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
                    this._history = text;
                  });
                },
              ),
            ),
            new Container(
              margin: EdgeInsets.only(bottom: 50),
              child: new Text(AppLocalizations.of(context).translate('detail_add'),
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
          new Expanded(child:
          ButtonTheme(
              minWidth: 200.0,
              height: 48.0,
              child:new RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text(AppLocalizations.of(context).translate('sent_confirm')),
                onPressed: () => _addBohaer(),
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
                  child: Text(AppLocalizations.of(context).translate('add_bohaer'),style: new TextStyle( fontSize: 18, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold),)
              )),
        ],
      ),
    );
  }

  void _addBohaer(){
    AddBohaerInput addBohaerInput = new AddBohaerInput();
    addBohaerInput.user_id = this._userId;
    addBohaerInput.phone = this._phone;
    addBohaerInput.name = this._name_or_fb;
    addBohaerInput.type = this._type;
    addBohaerInput.address = this._address;
    addBohaerInput.history = this._history;
    setState(() {
      _isLoading = true;
    });
    presenter.createBohaer(addBohaerInput);
  }
  void _showAlertError(BuildContext context, List<ErrorData> value) {
    String result = "";
    for(int i = 0;i< value.length;i++){
      result = result + value[i].message.toString() + "\n";
    }
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Error"),
              content: Text(result.trim()),
            )
    );
  }
  _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this._userId = prefs.getString(USER_ID)??"";
    });
  }
  @override
  void onError(List<ErrorData> items) {
    setState(() {
      _isLoading = false;
    });
    _showAlertError(context,items);
  }

  @override
  void onSuccess(AddBohaerResult items) {
    setState(() {
      _isLoading = false;
    });
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text(AppLocalizations.of(context).translate('create_success')),
//    ));
    navigationPage();
  }

}
class AddBohaerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AddBohaerPageState();
  }
}