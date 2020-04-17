import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/ui/di.dart';
import 'package:boha/ui/list/ListDataView.dart';

class ListPresenter{
}

class BasicListPresenter implements ListPresenter{
  ListDataView _listView;
  HotelRepository _repository;

  BasicListPresenter(this._listView) {
    _repository = new Injector().hotelRepository;
  }

  void loadHotels() {
    _repository
        .fetchHotels()
        .then((data) => _listView.onSuccess(data))
        .catchError((e) => _listView.onError(new FetchDataException(e.toString())));
  }
  @override
  set listView(ListDataView value) {
    _listView = value;
  }

}