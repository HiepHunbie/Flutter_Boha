import 'dart:convert';

import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/detail/CommentInput.dart';
import 'package:boha/model/detail/DislikeInput.dart';
import 'package:boha/model/detail/ListCommentData.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/ui/di.dart';
import 'package:boha/ui/detail/DetailView.dart';

class DetailPresenter{
}

class BasicDetailPresenter implements DetailPresenter{
  DetailView _listView;
  DetailRepository _repository;

  BasicDetailPresenter(this._listView) {
    _repository = new Injector().detailRepository;
  }

  void getComments(String posId) {
    _repository
        .getComments(posId)
        .then((data) => _listView.onSuccess(data.comments))
        .catchError((e) => _listView.onError((json.decode(e) as List).map((errors) => new ErrorData.fromJson(errors)).toList()));
  }

  void dislikePost(DislikeInput userInput) {
    _repository
        .dislikePost(body: userInput.toMap())
        .then((data) => _listView.onSuccessDislike(data))
        .catchError((e) => _listView.onError(getError(e.toString())));
  }

  void putComments(CommentInput userInput) {
    _repository
        .putComments(body: userInput.toMap())
        .then((data) => _listView.onSuccessPutComment(data))
        .catchError((e) => _listView.onError(getError(e.toString())));
  }

  List<ErrorData> getError(String dataResult){
    var data = json.decode(dataResult.replaceAll("Exception:", "").trim());
    var rest = data as List;

    return rest.map<ErrorData>((json) => ErrorData.fromJson(json)).toList();
  }

  @override
  set listView(DetailView value) {
    _listView = value;
  }

}