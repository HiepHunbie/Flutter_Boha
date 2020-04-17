import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/ui/list/ListDataView.dart';
import 'package:boha/ui/list/ListPresenter.dart';
import 'package:boha/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:boha/ui/detail/DetailComponent.dart';
import 'package:boha/ui/addBohaer/AddBohaerComponent.dart';
import 'package:boha/ui/info/InfoComponent.dart';
import 'package:boha/ui/getData/GetDataComponent.dart';
import  'package:flutter_svg/flutter_svg.dart';
import '../../app_localizations.dart';

class ListPageState extends State<ListPage> implements ListDataView {

  BasicListPresenter presenter;
  List<bool> isSelected ;
  String textSearch = "";
  List<Hotel> _hotels;
  bool _isLoading;
  ListPageState() {
    presenter = new BasicListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    presenter.loadHotels();
    isSelected = [true, false];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      appBar:  EmptyAppBar (),
      body: _isLoading
          ? new Center(
        child: new CircularProgressIndicator(),
      )
          : _hotelWidget(),
    );
  }

  Widget _hotelWidget() {
    return new Container(
        child: new Padding(
          padding: EdgeInsets.all(0.0),
          child: Stack(
            children: <Widget>[
              Align(alignment: Alignment.topCenter,
                  child:new Column(
                    children: <Widget>[
                      _topWidget(),
                      _searchWidget(),
                      _tabButton(),
                      _hotels.length>0 ? new Flexible(
                          child: isSelected[0] ?
                          new Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child:new ListView.builder(
                                itemCount: _hotels.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final Hotel hotel = _hotels[index];
                                  return _getCardItemUi(context, hotel);
                                },
                              )
                          ) :
                          new Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child:new ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                final Hotel hotel = _hotels[index];
                                return _getCardItemUi(context, hotel);
                              },
                            ),)
                      ) :
                      _textEmpty(),
                      _buttonGetData()
                    ],
                  )),
            ],
          ),)
    );
  }

  Widget _tabButton(){
    return new Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ToggleButtons(
              borderColor: Color(BORDER_BUTTON_GRAY),
              fillColor: Color(WHITE),
              borderWidth: 1,
              selectedBorderColor: Color(BORDER_BUTTON_GRAY),
              disabledBorderColor: Color(BORDER_BUTTON_GRAY),
              selectedColor: Color(TEXT_MAIN),
              borderRadius: BorderRadius.circular(5),
              children: <Widget>[

                Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10),
                    child: Row(children: <Widget>[
                      Text(AppLocalizations.of(context).translate('boha'),
                          style: TextStyle(fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold)),
                      Text("(2020)",
                          style: TextStyle(fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold)),
                    ],)
                ),
                Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10),
                    child: Row(children: <Widget>[
                      Text(AppLocalizations.of(context).translate('cheat'),
                          style: TextStyle(fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold)),
                      Text("(2020)",
                          style: TextStyle(fontSize: 14, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold)),
                    ],)
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                });
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }
  Widget _searchWidget(){
    return new Container(
      margin: EdgeInsets.only(bottom: 5,left: 10,right: 10),
      height: 40,
      child: new TextFormField(
        decoration:  new InputDecoration(
          contentPadding: EdgeInsets.only(left: 10),
          labelText: AppLocalizations.of(context).translate('phone'),
          labelStyle: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
          hintText: AppLocalizations.of(context).translate('hint_search'),
          hintStyle: TextStyle(
            color: Colors.black54,
            fontSize: 14.0,
          ),
//          contentPadding: new EdgeInsets.all(10.0),
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
          suffixIcon: new Padding(padding: EdgeInsets.zero,
              child: IconButton(
                  icon:Icon(Icons.search,size: 20, color: Color(TEXT_GRAY)),
                  onPressed: () => {})),
        ),
        textAlign: TextAlign.left,
        autofocus: false,
        keyboardType: TextInputType.phone,
        autocorrect: false,
        onChanged: (text) {
          setState((){
            this.textSearch = text;
          });
        },
      ),
    );
  }
  Widget _topWidget(){
    return new Container(
      margin: EdgeInsets.only(bottom: 10,top: 10,left: 10,right: 10),
      child: Stack(
        children: <Widget>[
          new Container(
            height: 32,
            child: new Align(
              alignment: Alignment.centerLeft,
              child: Text(AppLocalizations.of(context).translate('app_name_big'),
                  style: TextStyle(color: Color(TEXT_TITLE), fontSize: 28, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold)),
            ),
          ),
          new Container(
              height: 32,
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 5.0),
                      width: 73,
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            side: BorderSide(color: Color(BORDER_BUTTON_GRAY))),
                        onPressed: () => goToInfoScreen(context),
                        color: Color(BORDER_BUTTON_GRAY),
                        padding: EdgeInsets.all(6.0),
                        child: Row( // Rep
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(Icons.info,size: 17, color: Color(TEXT_GRAY)),
                            ),
                            Text(AppLocalizations.of(context).translate('info'),
                                style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontStyle: FontStyle.normal)),

                          ],
                        ),),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 5.0),
                      width: 135,
                      child: new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            side: BorderSide(color: Color(BORDER_BUTTON_BLUE))),
                        onPressed: () => goToAddNewBohaer(context),
                        color: Color(BORDER_BUTTON_BLUE),
                        padding: EdgeInsets.all(6.0),
                        child: Row( // Rep
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(Icons.person,size: 20, color: Color(WHITE)),
                            ),
                            Text(AppLocalizations.of(context).translate('add_bohaer'),
                                style: TextStyle(color: Color(WHITE), fontSize: 13, fontStyle: FontStyle.normal)),

                          ],
                        ),),
                    ),
                  ],
                ),
              ))

        ],
      ),
    );
  }

  Widget _getCardItemUi(BuildContext context, Hotel hotel) {
    return new GestureDetector(
        onTap: ()=> Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(hotelData : hotel)),
        ),
        child: new Card(
          child: new Padding(padding: EdgeInsets.all(10.0),
              child:new Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Align(alignment: Alignment.centerLeft,
                      child: Text(hotel.name,
                          style: TextStyle(color: Color(TEXT_TITLE), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),),
                    Align(alignment: Alignment.centerRight,
                      child: Text(hotel.id,
                          style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Medium',)),),
                  ],),
                  Container(
                    margin: EdgeInsets.only(top: 8,bottom: 8),
                    child: const MySeparator(color: Colors.grey),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(hotel.name,
                        style: TextStyle(color: Color(TEXT_MAIN), fontSize: 13, fontFamily: 'Montserrat Light',fontWeight: FontWeight.normal,)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(hotel.background,
                        style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Light',fontWeight: FontWeight.normal,)),
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(right: 5.0),
                        width: 50,
                        height: 32,
                        child: new FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16.0),
                              side: BorderSide(color: Color(BORDER_BUTTON_GRAY))),
                          onPressed: () => {},
                          color: Color(BORDER_BUTTON_GRAY),
                          padding: EdgeInsets.all(4.0),
                          child: Row( // Rep
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(Icons.pan_tool,size: 15, color: Color(TEXT_GRAY)),
                              ),
                              Text(hotel.id,
                                  style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontStyle: FontStyle.normal)),

                            ],
                          ),),
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 5.0),
                        width: 50,
                        height: 32,
                        child: new FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16.0),
                              side: BorderSide(color: Color(BORDER_BUTTON_GRAY))),
                          onPressed: () => {},
                          color: Color(BORDER_BUTTON_GRAY),
                          padding: EdgeInsets.all(4.0),
                          child: Row( // Rep
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Icon(Icons.mode_comment,size: 15, color: Color(TEXT_GRAY)),
                              ),
                              Text(hotel.id,
                                  style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontStyle: FontStyle.normal)),

                            ],
                          ),),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }

  Widget _buttonGetData(){
    return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GetDataPage()),
        ),
        child: new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/banner.png",),
              fit: BoxFit.cover,
            ),
          ),
//          color: Color(TEXT_MAIN),
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
          child:new Column(
            children: <Widget>[
              Container(alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10,right: 10),
                child:Text(AppLocalizations.of(context).translate('get_data_banner_title'),
                    style: TextStyle(color: Color(WHITE), fontSize: 13, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),),
              Container(alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child:Text(AppLocalizations.of(context).translate('get_data_banner_click'),
                    style: TextStyle(color: Color(TEXT_YELLOW), fontSize: 12, fontFamily: 'Montserrat Light',fontWeight: FontWeight.normal,)),)
            ],
          ) ,
        ));
  }
  Widget _textEmpty(){
    return new Container(
        margin: EdgeInsets.only(top: 10,left: 10,right: 10),
        child: new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                text: AppLocalizations.of(context).translate('first_error_empty'),
                style: new TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Montserrat Regular',fontStyle: FontStyle.normal),
              ),
              new TextSpan(
                text: AppLocalizations.of(context).translate('click_error_empty'),
                style: new TextStyle(color: Colors.blue, fontSize: 14, fontFamily: 'Montserrat Regular',fontStyle: FontStyle.normal),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => goToAddNewBohaer(context),
              ),
              new TextSpan(
                text: AppLocalizations.of(context).translate('last_error_empty'),
                style: new TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'Montserrat Regular',fontStyle: FontStyle.normal),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {  },
              )
            ],
          ),));
  }
  void goToAddNewBohaer(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBohaerPage()),
    );
  }
  void goToInfoScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoPage()),
    );
  }
  @override
  void onError(FetchDataException e) {
    print(e.toString());
  }

  @override
  void onSuccess(List<Hotel> items) {
    setState(() {
      _hotels = items;
      _isLoading = false;
    });
  }
}

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ListPageState();
  }
}