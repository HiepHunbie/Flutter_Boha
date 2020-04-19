import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/detail/DislikeResult.dart';
import 'package:boha/model/list/CountData.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/model/list/UserResult.dart';

abstract class ListDataView{
  void onSuccess(List<Hotel> items);
  void onError(List<ErrorData> e);
  void onSuccessRegister(List<UserResult> items);
  void onErrorRegister(List<ErrorData> e);
  void onSuccessDislike(DislikeResult items);
  void onSuccessGetCount(CountData items);
}