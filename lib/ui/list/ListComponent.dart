import 'dart:io';

import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/detail/DislikeInput.dart';
import 'package:boha/model/detail/DislikeResult.dart';
import 'package:boha/model/list/CountData.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/model/list/UserInput.dart';
import 'package:boha/model/list/UserResult.dart';
import 'package:boha/ui/list/ListDataView.dart';
import 'package:boha/ui/list/ListPresenter.dart';
import 'package:boha/utils/Colors.dart';
import 'package:boha/utils/Constants.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:boha/ui/detail/DetailComponent.dart';
import 'package:boha/ui/addBohaer/AddBohaerComponent.dart';
import 'package:boha/ui/info/InfoComponent.dart';
import 'package:boha/ui/getData/GetDataComponent.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:boha/utils/Alerts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_localizations.dart';

class ListPageState extends State<ListPage> with TickerProviderStateMixin implements ListDataView {
  BasicListPresenter presenter;
  List<bool> isSelected;
  UserInput user = new UserInput();
  String textSearch = "";
  List<Hotel> _hotels = new List();
  int _listCount = 1;
  int _countBoom = 0;
  int _countCheat = 0;
  String _phone = "";
  int _page = 1;
  int _limit = 5;
  bool _stopLoadMore = false;
  bool _isLoading;
  bool _isLoadMore = false;
  int _type = 1;
  String _userId = "";
  ListPageState() {
    presenter = new BasicListPresenter(this);
  }
  String deviceType = "";
  String deviceId = "test";
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _refreshController = RefreshController();
    presenter.loadHotels(_phone,_page,_limit,_type);
    presenter.getCount();
    isSelected = [true, false];
//    deviceId =  _getId();
    if (Platform.isAndroid) {
      deviceType = "android";
    }
    else if(Platform.isIOS) {
      deviceType = "ios";
    }
    this.user.device = deviceType;
    this.user.device_id = deviceId;
    _getUserId();

  }

  @override
  void dispose() {
    refreshData();
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
        refreshData();
      // Handle this case
        break;
      case AppLifecycleState.inactive:
      // Handle this case
        break;
      case AppLifecycleState.paused:
      // Handle this case
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        primary: true,
        appBar: EmptyAppBar(),
        body: RefreshConfiguration(
          child: SmartRefresher(
            header: WaterDropMaterialHeader(
              backgroundColor: Color(TEXT_MAIN),
              offset: MediaQuery.of(context).padding.top + 120.0,
            ),
            child:_hotelWidget(),
            controller: _refreshController,
            onRefresh: () {
              _refreshController.refreshCompleted();
              refreshData();
            },
          ),
        )
    );
  }

  Widget _hotelWidget() {
    return new Container(
        child: new Padding(
          padding: EdgeInsets.all(0.0),
          child: Stack(
            children: <Widget>[
              Align(alignment: Alignment.topCenter,
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      _topWidget(),
                      _searchWidget(),
                      _tabButton(),
                      _listCount > 0 ? new Container() :
                      _textEmpty(),
                      new Flexible(
                          child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!_stopLoadMore&&!_isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                  loadMore();
                                }
                              },
                              child: isSelected[0] ?
                              new Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: new ListView.builder(
                                    itemCount: _hotels.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final Hotel hotel = _hotels[index];
                                      return _getCardItemUi(context, hotel);
                                    },
                                  )
                              ) :
                              new Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: new ListView.builder(
                                  itemCount: _hotels.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final Hotel hotel = _hotels[index];
                                    return _getCardItemUi(context, hotel);
                                  },
                                ),)
                          )),
                      _buttonGetData(),
                    ],
                  )),
              _isLoading
                  ? new Container(
                alignment: Alignment.center,
                color: Color(BACK_TRANS_LOADING),
                width: double.infinity,
                height: double.infinity,
                child: new CircularProgressIndicator(),
              )
                  : new Container(),
            ],
          ),)
    );
  }

  Widget _tabButton() {
    return new Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Center(
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
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(children: <Widget>[
                      Text(AppLocalizations.of(context).translate('boha'),
                          style: TextStyle(fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              fontWeight: FontWeight.bold)),
                      Text(this._countBoom.toString(),
                          style: TextStyle(fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              fontWeight: FontWeight.bold)),
                    ],)
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(children: <Widget>[
                      Text(AppLocalizations.of(context).translate('cheat'),
                          style: TextStyle(fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              fontWeight: FontWeight.bold)),
                      Text(this._countCheat.toString(),
                          style: TextStyle(fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              fontWeight: FontWeight.bold)),
                    ],)
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                  if(isSelected[0]){
                    _type = 1;
                  }else{
                    _type = 2;
                  }
                  _stopLoadMore = false;
                  _page = 1;
                  _isLoading = true;
                  _isLoadMore = false;
                });
                presenter.loadHotels(_phone, _page, _limit,_type);
              },
              isSelected: isSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchWidget() {
    return new Container(
      margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
      height: 40,
      child: new TextFormField(
        decoration: new InputDecoration(
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
          border: OutlineInputBorder(
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
                  icon: Icon(Icons.search, size: 20, color: Color(TEXT_GRAY)),
                  onPressed: () => searchData(this.textSearch))),
        ),
        onFieldSubmitted: (term){
          searchData(this.textSearch);
        },
        textInputAction: TextInputAction.done,
        textAlign: TextAlign.left,
        autofocus: false,
        keyboardType: TextInputType.phone,
        autocorrect: false,
        onChanged: (text) {
          setState(() {
            this.textSearch = text;
          });
          if(text.length ==0){
            searchData(this.textSearch);
          }
        },
      ),
    );
  }

  Widget _topWidget() {
    return new Container(
      margin: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
      child: Stack(
        children: <Widget>[
          new Container(
            height: 32,
            child: new Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  AppLocalizations.of(context).translate('app_name_big'),
                  style: TextStyle(color: Color(TEXT_TITLE),
                      fontSize: 28,
                      fontFamily: 'Montserrat Bold',
                      fontWeight: FontWeight.bold)),
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
                              child: SvgPicture.asset("images/ic_info.svg",
                                  color: Color(TEXT_GRAY)),
                            ),
                            Text(AppLocalizations.of(context).translate('info'),
                                style: TextStyle(color: Color(TEXT_GRAY),
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal)),

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
                              child: Icon(
                                  Icons.person, size: 20, color: Color(WHITE)),
                            ),
                            Text(AppLocalizations.of(context).translate(
                                'add_bohaer'),
                                style: TextStyle(color: Color(WHITE),
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal)),

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
        onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(hotelData: hotel)),
            ),
        child: new Card(
          child: new Padding(padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  Stack(children: <Widget>[
                    Align(alignment: Alignment.centerLeft,
                      child: Text(hotel.phone,
                          style: TextStyle(color: Color(TEXT_TITLE),
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            fontWeight: FontWeight.bold,)),),
                    Align(alignment: Alignment.centerRight,
                      child: Text(hotel.name,
                          style: TextStyle(color: Color(TEXT_TITLE),
                            fontSize: 14,
                            fontFamily: 'Montserrat Medium',)),),
                  ],),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    child: const MySeparator(color: Colors.grey),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    alignment: Alignment.centerLeft,
                    child: Text(hotel.address,
                        style: TextStyle(color: Color(TEXT_MAIN),
                          fontSize: 13,
                          fontFamily: 'Montserrat Light',
                          fontWeight: FontWeight.normal,)),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Text(hotel.history,
                        style: TextStyle(color: Color(TEXT_TITLE),
                          fontSize: 14,
                          fontFamily: 'Montserrat Light',
                          fontWeight: FontWeight.normal,)),
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
                              side: BorderSide(
                                  color: Color(BORDER_BUTTON_GRAY))),
                          onPressed: () => _dislikePos(hotel.id.toString(),hotel),
                          color: Color(BORDER_BUTTON_GRAY),
                          padding: EdgeInsets.all(4.0),
                          child: Row( // Rep
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: SvgPicture.asset("images/ic_dislike.svg",
                                  color: Color(TEXT_GRAY),),
                              ),
                              Text(hotel.totalDislike.toString(),
                                  style: TextStyle(color: Color(TEXT_GRAY),
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal)),

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
                              side: BorderSide(
                                  color: Color(BORDER_BUTTON_GRAY))),
                          onPressed: () => {},
                          color: Color(BORDER_BUTTON_GRAY),
                          padding: EdgeInsets.all(4.0),
                          child: Row( // Rep
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                child: SvgPicture.asset("images/ic_comment.svg",
                                  color: Color(TEXT_GRAY),),
                              ),
                              Text(hotel.totalComment.toString(),
                                  style: TextStyle(color: Color(TEXT_GRAY),
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal)),

                            ],
                          ),),
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }

  Widget _buttonGetData() {
    return GestureDetector(
        onTap: () =>
            Navigator.push(
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
          padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
          child: new Column(
            children: <Widget>[
              Container(alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(AppLocalizations.of(context).translate(
                    'get_data_banner_title'),
                    style: TextStyle(
                      color: Color(WHITE),
                      fontSize: 13,
                      fontFamily: 'Montserrat Bold',
                      fontWeight: FontWeight.bold,)),),
              Container(alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                child: Text(AppLocalizations.of(context).translate(
                    'get_data_banner_click'),
                    style: TextStyle(
                      color: Color(TEXT_YELLOW),
                      fontSize: 12,
                      fontFamily: 'Montserrat Light',
                      fontWeight: FontWeight.normal,)),)
            ],
          ),
        ));
  }

  Widget _textEmpty() {
    return new Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: new RichText(
          text: new TextSpan(
            children: [
              new TextSpan(
                text: AppLocalizations.of(context).translate(
                    'first_error_empty'),
                style: new TextStyle(color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                    fontStyle: FontStyle.normal),
              ),
              new TextSpan(
                text: AppLocalizations.of(context).translate(
                    'click_error_empty'),
                style: new TextStyle(color: Colors.blue,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                    fontStyle: FontStyle.normal),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () => goToAddNewBohaer(context),
              ),
              new TextSpan(
                text: AppLocalizations.of(context).translate(
                    'last_error_empty'),
                style: new TextStyle(color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Montserrat Regular',
                    fontStyle: FontStyle.normal),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {},
              )
            ],
          ),));
  }

  void goToAddNewBohaer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddBohaerPage()),
    );
  }

  void goToInfoScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfoPage()),
    );
  }

  @override
  void onError(List<ErrorData> e) {
    print(e.toString());
    _showAlertError(context, e);
  }

  @override
  void onSuccess(List<Hotel> items) {
    setState(() {
      if(items.length<_limit){
        _stopLoadMore = true;
      }
      if(_isLoadMore){
        _hotels.addAll(items);
      }else{
        _hotels = items;
      }
      _listCount = _hotels.length;
      _isLoadMore= false;
      _isLoading = false;
    });
  }
  void loadMore() {
    setState(() {
      _isLoadMore= true;
      _isLoading = true;
      _page+=1;
      presenter.loadHotels(_phone,_page,_limit,_type);
    });
  }
  void refreshData(){
    _isLoading = true;
    presenter.loadHotels(_phone,_page,_limit,_type);
  }
  void searchData(String phone) {
    setState(() {
      _isLoadMore= false;
      _isLoading = true;
      _phone = phone;
      _page=1;
      presenter.loadHotels(_phone,_page,_limit,_type);
    });
  }
  _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId.toString(); // unique ID on Android
    }
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
    this._userId = prefs.getString(USER_ID)??"";
    if(this._userId.length == 0){
      presenter.registerUser(this.user);
    }
  }
  _saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_ID, userId);
  }

  @override
  void onErrorRegister(List<ErrorData> e) {
    _showAlertError(context, e);
  }

  @override
  void onSuccessRegister( List<UserResult> data){
    _saveUserId(data[0].shortId);
  }

  @override
  void onSuccessDislike(DislikeResult items) {
  }

  void _dislikePos(String postId, Hotel hotel){
    DislikeInput dislikeInput = new DislikeInput();
    dislikeInput.user_id = this._userId;
    dislikeInput.post_id = postId;
    dislikeInput.type = 1;
    dislikeInput.total_dislike = 1;
    presenter.dislikePost(dislikeInput);
    setState(() {
      hotel.totalDislike += 1;
    });
  }

  @override
  void onSuccessGetCount(CountData items) {
    setState(() {
      this._countBoom = items.totalBoomCount;
      this._countCheat = items.cheatCount;
    });
  }
}

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ListPageState();
  }
}