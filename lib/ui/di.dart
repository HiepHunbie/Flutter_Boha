import 'package:boha/data/list/NetworkService.dart';
import 'package:boha/model/list/ListData.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  HotelRepository get hotelRepository => new HotelNetworkRepository();
//  LoginRepository get loginRepository => new LoginNetworkRepository();
}