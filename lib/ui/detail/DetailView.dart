import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/detail/DislikeResult.dart';
import 'package:boha/model/detail/ListCommentData.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/model/ErrorData.dart';

abstract class DetailView{
  void onSuccess(List<Comment> items);
  void onError(List<ErrorData> items);
  void onSuccessPutComment(DislikeResult items);
  void onSuccessDislike(DislikeResult items);
}