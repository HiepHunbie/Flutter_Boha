import 'dart:async';
import 'dart:convert';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/getData/GetDataResult.dart';
import 'package:boha/utils/Constants.dart';
import 'package:http/http.dart' as http;

class GetDataNetworkRepository implements GetDataRepository {
  @override
  Future<GetDataResult> getDataInfo({Map body}) async {
    String url = BASE_URL + "documents";
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body) );
    final statusCode = response.statusCode;
    var data = json.decode(response.body);
    if(statusCode == 409){
      throw new Exception(GetDataResult.fromJson(data).message);
    }else if (statusCode != 200 || data == null) {
      throw new Exception(getError(response.body.toString()));
    }

    return GetDataResult.fromJson(data);
  }

  String getError(String dataResult){
    var data = json.decode(dataResult.replaceAll("Exception:", "").trim());
    var rest = data as List;
    var listData = rest.map<ErrorData>((json) => ErrorData.fromJson(json)).toList();
    String result = "";
    for(int i = 0;i< listData.length;i++){
      result = result + listData[i].message.toString() + "\n";
    }
    return result;
  }
}