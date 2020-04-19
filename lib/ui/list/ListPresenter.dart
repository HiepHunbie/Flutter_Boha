import 'dart:convert';

import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/detail/DislikeInput.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/model/list/UserInput.dart';
import 'package:boha/ui/di.dart';
import 'package:boha/ui/list/ListDataView.dart';

class ListPresenter{
}

class BasicListPresenter implements ListPresenter{
  ListDataView _listView;
  HotelRepository _repository;

  BasicListPresenter(this._listView) {
    _repository = new Injector().hotelRepository;
  }

  void loadHotels(String phone,int page, int litmit,int type) {
    _repository
        .fetchHotels(phone,page,litmit,type)
        .then((data) => _listView.onSuccess(data))
        .catchError((e) => _listView.onError(getError(e.toString())));
  }

  void getCount(){
    _repository
        .getCount()
        .then((data) => _listView.onSuccessGetCount(data))
        .catchError((e) => _listView.onError(getError(e.toString())));
  }
  void registerUser(UserInput userInput) {
    _repository
        .registerUser(body: userInput.toMap())
        .then((data) => _listView.onSuccessRegister(data))
        .catchError((e) => _listView.onErrorRegister(getError(e.toString())));
  }

  List<ErrorData> getError(String dataResult){
    var data = json.decode(dataResult.replaceAll("Exception:", "").trim());
    var rest = data as List;

    return rest.map<ErrorData>((json) => ErrorData.fromJson(json)).toList();
  }

  void dislikePost(DislikeInput userInput) {
    _repository
        .dislikePost(body: userInput.toMap())
        .then((data) => _listView.onSuccessDislike(data))
        .catchError((e) => _listView.onError(getError(e.toString())));
  }

  @override
  set listView(ListDataView value) {
    _listView = value;
  }


}