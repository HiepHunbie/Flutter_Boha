import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/list/ListData.dart';

abstract class ListDataView{
  void onSuccess(List<Hotel> items);
  void onError(FetchDataException e);
}