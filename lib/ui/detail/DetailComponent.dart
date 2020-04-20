import 'dart:math';

import 'package:boha/components/EmptyAppBar.dart';
import 'package:boha/components/MySeparator.dart';
import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/detail/CommentInput.dart';
import 'package:boha/model/detail/DislikeInput.dart';
import 'package:boha/model/detail/DislikeResult.dart';
import 'package:boha/model/detail/ListCommentData.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/ui/list/ListComponent.dart';
import 'package:boha/utils/Colors.dart';
import 'package:boha/utils/Constants.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_localizations.dart';
import 'DetailPresenter.dart';
import 'DetailView.dart';

class DetailPageState extends State<DetailPage> implements DetailView {
  String _comment = "";
  String _userId = "";
  String posId = "";
  final _textInput = TextEditingController();
  Hotel hotel;
  List<Comment> _hotels;
  bool _isLoading;
  BasicDetailPresenter presenter;
  int totalDislike = 0;
  DetailPageState(Hotel hotelData) {
    presenter = new BasicDetailPresenter(this);
    this.hotel = hotelData;
    this.posId = hotelData.id.toString();
    this.totalDislike = hotelData.totalDislike;
  }


  @override
  void initState() {
    super.initState();
    _isLoading = true;
    presenter.getComments(this.posId);
    _getUserId();
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


  Widget _commentWidget(){
    return new Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 48,
      child: new TextFormField(
        decoration:  new InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            labelStyle: TextStyle(
              color: Colors.black54,
              fontSize: 14.0,
            ),
            hintText: AppLocalizations.of(context).translate('add_comment'),
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
            suffixIcon: GestureDetector(
              onTap: () => _putComment(this._comment),
              child:Transform.rotate(
                angle: 90 * pi / 180,
                child: Padding(padding: EdgeInsets.all(8),child: new Container(
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(TEXT_MAIN)
                  ),
                  child: Padding(padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("images/ic_send.svg",color: Color(WHITE))),),),),)
        ),
        controller: this._textInput,
        textAlign: TextAlign.left,
        autofocus: false,
        keyboardType: TextInputType.text,
        autocorrect: false,
        onChanged: (text) {
          setState((){
            this._comment = text;
          });
        },
      ),
    );
  }

  Widget _hotelWidget() {
    return new Container(
      color: Colors.white,
      child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Stack(
            children: <Widget>[
              Align(alignment: Alignment.topCenter,
                child: new Column(
                  children: <Widget>[
                    _titleTop(),
                    _getDetailItemUi(context, hotel),
                    Container(
                      margin: EdgeInsets.only(top: 8,bottom: 8),
                      child: const MySeparator(color: Colors.grey),
                    ),
                    new Flexible(
                      child: new ListView.builder(
                        itemCount: _hotels.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Comment hotel = _hotels[index];
                          return _getCardItemUi(context, hotel);
                        },
                      ),
                    ),
                    _commentWidget()
                  ],
                ),)
            ],
          )

      ),
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
            onPressed: ()=> Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPage())),
          ),
          Expanded(
              child: Align(alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context).translate('export_of_karma'),style: new TextStyle( fontSize: 18, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold),)
              )),
        ],
      ),
    );
  }

  Widget _getDetailItemUi(BuildContext context, Hotel hotel) {
    return new Card(
      child: new Padding(padding: EdgeInsets.all(10.0),
          child:new Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Align(alignment: Alignment.centerLeft,
                  child: Text(hotel.phone,
                      style: TextStyle(color: Color(TEXT_TITLE), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),),
                Align(alignment: Alignment.centerRight,
                  child: Text(hotel.name,
                      style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Medium',)),),
              ],),
              Container(
                margin: EdgeInsets.only(top: 8,bottom: 8),
                child: const MySeparator(color: Colors.grey),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text("Tỉnh lộ 10, bình tân, 3-2 quận 10",
                    style: TextStyle(color: Color(TEXT_MAIN), fontSize: 13, fontFamily: 'Montserrat Light',fontWeight: FontWeight.normal,)),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Text("Đặt rất sang mồm, đòi giao gấp, đơn mấy triệu cơ, tx đến giao gọi auto chặn hoặc chỉ đi lòng vòng rồi khoá máy, số lạ gọi vẫn nghe và bảo nhận hàng bình thường, chó má",
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
                      onPressed: () => _dislikePos(),
                      color: Color(BORDER_BUTTON_GRAY),
                      padding: EdgeInsets.all(4.0),
                      child: Row( // Rep
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: SvgPicture.asset("images/ic_dislike.svg",color: Color(TEXT_GRAY),),
                          ),
                          Text(totalDislike.toString(),
                              style: TextStyle(color: Color(TEXT_GRAY), fontSize: 12, fontStyle: FontStyle.normal)),

                        ],
                      ),),
                  )
                ],
              ),
            ],
          )),
    );
  }

  void _dislikePos(){
    DislikeInput dislikeInput = new DislikeInput();
    dislikeInput.user_id = this._userId;
    dislikeInput.post_id = this.posId;
    dislikeInput.type = 1;
    dislikeInput.total_dislike = 1;
    presenter.dislikePost(dislikeInput);
    setState(() {
      totalDislike = totalDislike += 1;
    });
  }
  void _putComment(String comment){
    CommentInput commentInput = new CommentInput();
    commentInput.user_id = this._userId;
    commentInput.post_id = this.posId;
    commentInput.type = 2;
    commentInput.comment = comment;
    presenter.putComments(commentInput);
  }
  _getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this._userId = prefs.getString(USER_ID)??"";
    });
  }
  String _genDateComment(String dateGen){
    DateTime todayDate = DateTime.parse(dateGen);
    return formatDate(todayDate, [dd, '/', mm, '/', yyyy, ' ', hh, ':', nn])  ;
  }
  Widget _getCardItemUi(BuildContext context, Comment hotel) {
    return new Card(
      child: new Padding(padding: EdgeInsets.all(10.0),
          child:new Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Align(alignment: Alignment.centerLeft,
                  child: Text(hotel.user_name,
                      style: TextStyle(color: Color(TEXT_TITLE), fontSize: 16, fontFamily: 'Montserrat Bold',fontWeight: FontWeight.bold,)),),
                Align(alignment: Alignment.centerRight,
                  child: Text(_genDateComment(hotel.createdAt.toString()),
                      style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Medium',)),),
              ],),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                alignment: Alignment.centerLeft,
                child: Text(hotel.message,
                    style: TextStyle(color: Color(TEXT_TITLE), fontSize: 14, fontFamily: 'Montserrat Light',fontWeight: FontWeight.normal,)),
              ),
              Container(
                margin: EdgeInsets.only(top: 8,bottom: 8),
                child: const MySeparator(color: Colors.grey),
              ),
            ],
          )),
    );
  }

  @override
  void onError(List<ErrorData> e) {
    print(e.toString());
    _showAlertError(context,e);
  }

  @override
  void onSuccess(List<Comment> items) {
    setState(() {
      _hotels = items;
      _isLoading = false;
    });
  }

  @override
  void onSuccessDislike(DislikeResult items) {

  }

  @override
  void onSuccessPutComment(DislikeResult items) {
    setState(() {
      this._textInput.clear();
    });
    presenter.getComments(this.posId);
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
}

class DetailPage extends StatefulWidget {
  final Hotel hotelData;
  // In the constructor, require a Todo.
  DetailPage({Key key, @required this.hotelData}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new DetailPageState(hotelData);
  }
}