import 'package:boha/data/FetchDataException.dart';
import 'package:boha/model/list/ListData.dart';
import 'package:boha/ui/di.dart';
import 'package:boha/ui/detail/DetailView.dart';

class DetailPresenter{
}

class BasicDetailPresenter implements DetailPresenter{
  DetailView _listView;
  HotelRepository _repository;

  BasicDetailPresenter(this._listView) {
    _repository = new Injector().hotelRepository;
  }

  void loadHotels() {
    _repository
        .fetchHotels()
        .then((data) => _listView.onSuccess(data))
        .catchError((e) => _listView.onError(new FetchDataException(e.toString())));
  }
  @override
  set listView(DetailView value) {
    _listView = value;
  }

}