import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/addBohaer/AddBohaerResult.dart';

abstract class AddBohaerView{
  void onSuccess(AddBohaerResult items);
  void onError(List<ErrorData> items);
}