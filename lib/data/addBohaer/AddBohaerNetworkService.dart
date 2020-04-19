import 'dart:async';
import 'dart:convert';
import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/addBohaer/AddBohaerResult.dart';
import 'package:boha/model/detail/DislikeResult.dart';
import 'package:boha/model/detail/ListCommentData.dart';
import 'package:boha/model/list/UserResult.dart';
import 'package:boha/utils/Constants.dart';
import 'package:http/http.dart' as http;

import 'package:boha/model/list/ListData.dart';

class AddBohaerNetworkRepository implements AddBohaerRepository {

  @override
  Future<AddBohaerResult> createBohaer({Map body}) async {
    String url = BASE_URL + "post";
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body) );
    final statusCode = response.statusCode;
    var data = json.decode(response.body);
    if (statusCode != 200 || data == null) {
      throw new Exception(response.body.toString());
    }

    return AddBohaerResult.fromJson(data);
  }
}