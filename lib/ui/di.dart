import 'package:boha/data/addBohaer/AddBohaerNetworkService.dart';
import 'package:boha/data/detail/DetailNetworkService.dart';
import 'package:boha/data/getData/GetDataNetworkService.dart';
import 'package:boha/data/list/ListNetworkService.dart';
import 'package:boha/model/addBohaer/AddBohaerResult.dart';
import 'package:boha/model/detail/ListCommentData.dart';
import 'package:boha/model/getData/GetDataResult.dart';
import 'package:boha/model/list/ListData.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  HotelRepository get hotelRepository => new HotelNetworkRepository();
  DetailRepository get detailRepository => new DetailNetworkRepository();
  AddBohaerRepository get addBohaerRepository => new AddBohaerNetworkRepository();
  GetDataRepository get getDataRepository => new GetDataNetworkRepository();
}