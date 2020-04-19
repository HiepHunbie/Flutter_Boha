import 'dart:convert';

import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/addBohaer/AddBohaerInput.dart';
import 'package:boha/model/addBohaer/AddBohaerResult.dart';
import 'package:boha/ui/addBohaer/AddBohaerView.dart';

import '../di.dart';

class AddBohaerPresenter{
}

class BasicAddBohaerPresenter implements AddBohaerPresenter{
  AddBohaerView _listView;
  AddBohaerRepository _repository;

  BasicAddBohaerPresenter(this._listView) {
    _repository = new Injector().addBohaerRepository;
  }

  void createBohaer(AddBohaerInput userInput) {
    _repository
        .createBohaer(body: userInput.toMap())
        .then((data) => _listView.onSuccess(data))
        .catchError((e) => _listView.onError(getError(e.toString())));
  }
  List<ErrorData> getError(String dataResult){
    var data = json.decode(dataResult.replaceAll("Exception:", "").trim());
    var rest = data as List;

    return rest.map<ErrorData>((json) => ErrorData.fromJson(json)).toList();
  }
  @override
  set listView(AddBohaerView value) {
    _listView = value;
  }

}