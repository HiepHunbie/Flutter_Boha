import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/getData/GetDataResult.dart';

abstract class GetDataView{
  void onSuccess(GetDataResult items);
  void onError(String items);
}