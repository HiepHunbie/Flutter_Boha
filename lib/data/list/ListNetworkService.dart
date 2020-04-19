import 'dart:async';
import 'dart:convert';
import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/ErrorData.dart';
import 'package:boha/model/detail/DislikeResult.dart';
import 'package:boha/model/list/CountData.dart';
import 'package:boha/model/list/UserResult.dart';
import 'package:boha/utils/Constants.dart';
import 'package:http/http.dart' as http;

import 'package:boha/model/list/ListData.dart';

class HotelNetworkRepository implements HotelRepository {
  @override
  Future<List<Hotel>> fetchHotels(String phone,int page, int limit, int type) async {
    String url = BASE_URL + "posts?phone="+phone+"&page="+page.toString()+"&limit="+limit.toString()+"&type="+type.toString();
    http.Response response = await http.get(url);
    final statusCode = response.statusCode;
    var data = json.decode(response.body);
    var rest = data as List;
    if (statusCode != 200 || data == null) {
      throw new Exception(response.body.toString());
    }

    return rest.map<Hotel>((json) => Hotel.fromJson(json)).toList();
  }

  @override
  Future<DislikeResult> dislikePost({Map body}) async {
    String url = BASE_URL + "actions";
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body) );
    final statusCode = response.statusCode;
    var data = json.decode(response.body);
    if (statusCode != 200 || data == null) {
      throw new Exception(response.body.toString());
    }
    return DislikeResult.fromJson(data);
  }

  @override
  Future<List<UserResult>> registerUser({Map body}) async {
    String url = BASE_URL + "register";
    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: json.encode(body) );
    final statusCode = response.statusCode;
    var data = json.decode(response.body);
    var rest = data as List;
    if (statusCode != 200 || data == null) {
      throw new Exception(response.body.toString());
    }

    return rest.map<UserResult>((json) => UserResult.fromJson(json)).toList();
  }

  @override
  Future<CountData> getCount() async {
    String url = BASE_URL + "count-post";
    http.Response response = await http.get(url);
    final statusCode = response.statusCode;
    var data = json.decode(response.body);
    if (statusCode == 500){

    }else if (statusCode != 200 || data == null) {
      throw new Exception(response.body.toString());
    }


    return CountData.fromJson(data);
  }
}