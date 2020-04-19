import 'dart:convert';

import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/getData/GetDataInput.dart';
import 'package:boha/model/getData/GetDataResult.dart';
import 'package:boha/ui/getData/GetDataView.dart';

import '../di.dart';

class GetDataPresenter{
}

class BasicGetDataPresenter implements GetDataPresenter{
  GetDataView _listView;
  GetDataRepository _repository;

  BasicGetDataPresenter(this._listView) {
    _repository = new Injector().getDataRepository;
  }

  void getDataInfo(GetDataInput userInput) {
    _repository
        .getDataInfo(body: userInput.toMap())
        .then((data) => _listView.onSuccess(data))
        .catchError((e) => _listView.onError(e.toString().replaceAll("Exception:", "").trim()));
  }



  @override
  set listView(GetDataView value) {
    _listView = value;
  }

}